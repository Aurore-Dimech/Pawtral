import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../data/local/animal_information_entity.dart';
import '../data/local/isar_database.dart';
import '../repositories/local_information_repository.dart';

final isarProvider = FutureProvider<Isar>((ref) async {
  final database = IsarDatabase();
  final isar = await database.open();

  ref.onDispose(() async {
    await isar.close();
  });

  return isar;
});

final localInformationRepositoryProvider =
    FutureProvider<LocalInformationRepository>((ref) async {
  final isar = await ref.watch(isarProvider.future);

  return LocalInformationRepository(isar);
});

final localInformationProvider =
    FutureProvider<List<AnimalInformationEntity>>((ref) async {
  final repository =
      await ref.watch(localInformationRepositoryProvider.future);

  return repository.getAllInformation();
});