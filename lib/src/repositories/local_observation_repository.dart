import 'package:isar/isar.dart';

import '../data/local/animal_observation_entity.dart';

class LocalObservationRepository {
  const LocalObservationRepository(this._isar);

  final Isar _isar;

  Future<int> addObservation({
    required String animalName,
    required String imagePath,
    double? latitude,
    double? longitude,
  }) async {
    final observation = AnimalObservationEntity()
      ..animalName = animalName
      ..imagePath = imagePath
      ..createdAt = DateTime.now()
      ..isSynchronized = false
      ..latitude = latitude
      ..longitude = longitude;

    await _isar.writeTxn(() async {
      await _isar.animalObservationEntitys.put(observation);
    });

    return observation.id;
  }

  Future<List<AnimalObservationEntity>> getAllObservations() {
    return _isar.animalObservationEntitys
        .where()
        .sortByCreatedAtDesc()
        .findAll();
  }
}
