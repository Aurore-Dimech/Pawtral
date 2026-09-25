import 'package:isar_community/isar.dart';

part 'animal_cache_entity.g.dart';

@collection
class AnimalCacheEntity {
  Id id = Isar.autoIncrement;

  late String animalName;
  late String jsonData; 
  late DateTime createdAt;

  @Index()
  late String animalNameIndex;
}
