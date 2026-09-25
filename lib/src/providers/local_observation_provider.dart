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

final localObservationsProvider =
    FutureProvider.family<List<AnimalObservationEntity>, String>((
      ref,
      userId,
    ) async {
      final syncService = await ref.watch(
        observationSyncServiceProvider.future,
      );
      await syncService.synchronize();

      final repository = await ref.watch(
        localObservationRepositoryProvider.future,
      );

      return repository.getAllObservations(userId);
    });
