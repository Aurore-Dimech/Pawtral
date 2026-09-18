import 'package:isar/isar.dart';

part 'animal_observation_entity.g.dart';

@collection
class AnimalObservationEntity {
  Id id = Isar.autoIncrement;

  late String animalName;
  late String imagePath;
  late DateTime createdAt;
  late bool isSynchronized;

  double? latitude;
  double? longitude;
}