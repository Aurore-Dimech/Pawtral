import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';

import '../services/picture_service.dart';

final pictureServiceProvider = Provider<PictureService>((ref) {
  return PictureService();
});

final selectedPictureProvider = StateProvider<XFile?>((ref) {
  return null;
});