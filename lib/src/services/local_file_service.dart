import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class LocalFileService {
  Future<File> copyToApplicationDirectory(XFile picture) async {
    final directory = await getApplicationDocumentsDirectory();

    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

    final destination = File('${directory.path}/$fileName');

    return File(picture.path).copy(destination.path);
  }
}