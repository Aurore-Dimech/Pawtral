import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'animal_information_entity.dart';

class IsarDatabase {
  Future<Isar> open() async {
    final directory = await getApplicationDocumentsDirectory();

    return Isar.open(
      [AnimalInformationEntitySchema],
      directory: directory.path,
    );
  }
}