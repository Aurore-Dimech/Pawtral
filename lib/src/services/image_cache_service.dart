import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ImageCacheService {
  ImageCacheService({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  final Dio _dio;
  static const String _imageCacheFolder = 'animal_images_cache';

  Future<String?> downloadAndCacheImage(
    String imageUrl,
    String animalName,
  ) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final cacheDir = Directory('${directory.path}/$_imageCacheFolder');

      if (!cacheDir.existsSync()) {
        cacheDir.createSync(recursive: true);
      }

      final fileName =
          '${animalName}_${imageUrl.hashCode.abs().toString()}.jpg';
      final filePath = '${cacheDir.path}/$fileName';
      final file = File(filePath);

      if (file.existsSync()) {
        return filePath;
      }

      await _dio.download(imageUrl, filePath);

      return filePath;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getImageFromCache(String animalName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final cacheDir = Directory('${directory.path}/$_imageCacheFolder');

      if (!cacheDir.existsSync()) {
        return null;
      }

      final files = cacheDir.listSync();
      for (final file in files) {
        if (file.path.contains(animalName) && file.path.endsWith('.jpg')) {
          return file.path;
        }
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  Future<void> deleteImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (file.existsSync()) {
        await file.delete();
      }
    } catch (_) {}
  }

  Future<void> clearAllCache() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final cacheDir = Directory('${directory.path}/$_imageCacheFolder');

      if (cacheDir.existsSync()) {
        cacheDir.deleteSync(recursive: true);
      }
    } catch (_) {}
  }
}
