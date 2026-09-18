import 'package:isar/isar.dart';

part 'animal_information_entity.g.dart';

@collection
class AnimalInformationEntity {
  Id id = Isar.autoIncrement;

  late String animalName;
  late String imagePath;
  late DateTime createdAt;

  double? latitude;
  double? longitude;
}