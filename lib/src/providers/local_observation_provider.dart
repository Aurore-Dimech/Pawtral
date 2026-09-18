import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../data/local/animal_observation_entity.dart';
import '../data/local/isar_database.dart';
import '../repositories/local_observation_repository.dart';

final isarProvider = FutureProvider<Isar>((ref) async {
  final database = IsarDatabase();
  final isar = await database.open();

  ref.onDispose(() async {
    await isar.close();
  });

  return isar;
});

final localObservationRepositoryProvider =
    FutureProvider<LocalObservationRepository>((ref) async {
  final isar = await ref.watch(isarProvider.future);

  return LocalObservationRepository(isar);
});

final localObservationsProvider =
    FutureProvider<List<AnimalObservationEntity>>((ref) async {
  final repository =
      await ref.watch(localObservationRepositoryProvider.future);

  return repository.getAllObservations();
});