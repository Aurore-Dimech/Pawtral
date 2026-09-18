import 'package:isar/isar.dart';

import '../data/local/animal_information_entity.dart';

class LocalInformationRepository {
  const LocalInformationRepository(this._isar);

  final Isar _isar;

  Future<int> addInformation({
    required String animalName,
    required String imagePath,
    double? latitude,
    double? longitude,
  }) async {
    final information = AnimalInformationEntity()
      ..animalName = animalName
      ..imagePath = imagePath
      ..createdAt = DateTime.now()
      ..latitude = latitude
      ..longitude = longitude;

    await _isar.writeTxn(() async {
      await _isar.animalInformationEntitys.put(information);
    });

    return information.id;
  }

  Future<List<AnimalInformationEntity>> getAllInformation() {
    return _isar.animalInformationEntitys
        .where()
        .sortByCreatedAtDesc()
        .findAll();
  }
}