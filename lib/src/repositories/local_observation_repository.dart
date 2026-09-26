import 'package:isar_community/isar.dart';

import '../data/local/animal_observation_entity.dart';

class LocalObservationRepository {
  const LocalObservationRepository(this._isar);

  final Isar _isar;

  Future<int> addObservation({
    required String remoteId,
    required String userId,
    required String animalName,
    required String imagePath,
    double? latitude,
    double? longitude,
    String? cachedImagePath,
  }) async {
    final observation = AnimalObservationEntity()
      ..remoteId = remoteId
      ..userId = userId
      ..animalName = animalName
      ..imagePath = imagePath
      ..createdAt = DateTime.now()
      ..isSynchronized = false
      ..latitude = latitude
      ..longitude = longitude
      ..cachedImagePath = cachedImagePath;

    await _isar.writeTxn(() async {
      await _isar.animalObservationEntitys.put(observation);
    });

    return observation.id;
  }

  Future<List<AnimalObservationEntity>> getAllObservations(String userId) {
    return _isar.animalObservationEntitys
        .filter()
        .userIdEqualTo(userId)
        .sortByCreatedAtDesc()
        .findAll();
  }

  Future<void> saveRemoteObservation({
    required String remoteId,
    required String userId,
    required String animalName,
    required String imagePath,
    required DateTime createdAt,
    double? latitude,
    double? longitude,
  }) async {
    final existing = await getAllObservations(userId);
    final alreadySaved = existing.any(
      (observation) =>
          observation.remoteId == remoteId ||
          (observation.animalName == animalName &&
              observation.imagePath == imagePath &&
              observation.createdAt == createdAt),
    );

    if (alreadySaved) {
      return;
    }

    final observation = AnimalObservationEntity()
      ..remoteId = remoteId
      ..userId = userId
      ..animalName = animalName
      ..imagePath = imagePath
      ..createdAt = createdAt
      ..isSynchronized = true
      ..latitude = latitude
      ..longitude = longitude;

    await _isar.writeTxn(() async {
      await _isar.animalObservationEntitys.put(observation);
    });
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

  Future<List<AnimalObservationEntity>> getUnsynchronizedObservations(
    String userId,
  ) async {
    final observations = await _isar.animalObservationEntitys
        .filter()
        .userIdEqualTo(userId)
        .and()
        .isSynchronizedEqualTo(false)
        .findAll();

    return observations;
  }

  Future<AnimalObservationEntity?> getById(int observationId) {
    return _isar.animalObservationEntitys.get(observationId);
  }
}
