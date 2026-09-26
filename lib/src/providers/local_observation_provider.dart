import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';

import '../data/local/animal_observation_entity.dart';
import '../data/local/isar_database.dart';
import '../repositories/local_observation_repository.dart';
import '../services/observation_sync_service.dart';
import '../services/animal_cache_service.dart';
import 'firestore_provider.dart';

final isarProvider = FutureProvider<Isar>((ref) async {
  final database = IsarDatabase();
  final isar = await database.open();

  ref.onDispose(() async {
    await isar.close();
  });

  return isar;
});

final animalCacheServiceProvider = FutureProvider<AnimalCacheService>((
  ref,
) async {
  final isar = await ref.watch(isarProvider.future);
  return AnimalCacheService(isar);
});

final localObservationRepositoryProvider =
    FutureProvider<LocalObservationRepository>((ref) async {
      final isar = await ref.watch(isarProvider.future);

      return LocalObservationRepository(isar);
    });

final observationSyncServiceProvider = FutureProvider<ObservationSyncService>((
  ref,
) async {
  final repository = await ref.watch(localObservationRepositoryProvider.future);

  return ObservationSyncService(
    localRepository: repository,
    firestoreService: ref.watch(firestoreServiceProvider),
  );
});

final connectivityStreamProvider = StreamProvider<bool>((ref) async* {
  final connectivity = Connectivity();
  final initialResults = await connectivity.checkConnectivity();
  yield !initialResults.contains(ConnectivityResult.none);

  yield* connectivity.onConnectivityChanged.map((results) {
    final isOnline = !results.contains(ConnectivityResult.none);
    debugPrint('Connectivity changed: isOnline=$isOnline');
    return isOnline;
  });
});

final localObservationsProvider =
    FutureProvider.family<List<AnimalObservationEntity>, String>((
      ref,
      userId,
    ) async {
      final repository = await ref.watch(
        localObservationRepositoryProvider.future,
      );

      final asyncConnectivity = ref.watch(connectivityStreamProvider);
      final isOnline = asyncConnectivity.when(
        data: (value) => value,
        loading: () => false,
        error: (error, stack) => false,
      );

      if (isOnline) {
        try {
          final syncService = await ref.watch(
            observationSyncServiceProvider.future,
          );
          await syncService.synchronize().timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              debugPrint('Sync timeout (10s)');
            },
          );
        } catch (error, stackTrace) {
          debugPrint('Error: $error');
          debugPrintStack(stackTrace: stackTrace);
        }
      } else {
        debugPrint('Offline mode - skipping sync');
      }

      final localObservations = await repository.getAllObservations(userId);

      return localObservations;
    });

final animalObservationsProvider =
    FutureProvider.family<List<AnimalObservationEntity>, (String, String)>((
      ref,
      params,
    ) async {
      final (userId, animalName) = params;
      final observations = await ref.watch(
        localObservationsProvider(userId).future,
      );

      return observations.where((obs) => obs.animalName == animalName).toList();
    });
