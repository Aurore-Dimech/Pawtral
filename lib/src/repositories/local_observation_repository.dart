import 'package:isar_community/isar.dart';

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

  Future<void> markAsSynchronized(int observationId) async {
    final observation = await _isar.animalObservationEntitys.get(observationId);

    if (observation == null) {
      throw Exception('Local observation not found.');
    }

    observation.isSynchronized = true;

    await _isar.writeTxn(() async {
      await _isar.animalObservationEntitys.put(observation);
    });
  }

  Future<List<AnimalObservationEntity>> getUnsynchronizedObservations() {
    return _isar.animalObservationEntitys
        .filter()
        .isSynchronizedEqualTo(false)
        .findAll();
  }
}
