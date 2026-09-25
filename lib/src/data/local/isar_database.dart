import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'animal_observation_entity.dart';
import 'animal_cache_entity.dart';

class IsarDatabase {
  Future<Isar> open() async {
    final directory = await getApplicationDocumentsDirectory();

    return Isar.open([
      AnimalObservationEntitySchema,
      AnimalCacheEntitySchema,
    ], directory: directory.path);
  }
}
