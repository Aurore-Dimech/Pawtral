import 'package:dio/dio.dart';

import '../models/animal_model.dart';
import 'animal_cache_service.dart';

class AnimalService {
  AnimalService({Dio? dio, this._cacheService})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              sendTimeout: const Duration(seconds: 10),
            ),
          );

  final Dio _dio;
  final AnimalCacheService? _cacheService;

  Future<Animal> fetchAnimal(String name) async {
    try {
      if (_cacheService != null) {
        final cachedData = await _cacheService.getFromCache(name);
        if (cachedData != null) {
          final animals = cachedData['animals'] as List?;
          if (animals != null && animals.isNotEmpty) {
            return Animal.fromJson(
              Map<String, dynamic>.from(animals.first as Map),
            );
          }
        }
      }

      final response = await _dio.get<List<dynamic>>(
        'https://api.api-ninjas.com/v1/animals',
        queryParameters: {'name': name},
        options: Options(
          headers: {
            'X-Api-Key': const String.fromEnvironment('ANIMAL_API_KEY'),
          },
        ),
      );

      final animals = response.data;

      if (animals == null || animals.isEmpty) {
        throw Exception('Animal "$name" not found.');
      }

      if (_cacheService != null) {
        await _cacheService.saveToCache(name, {'animals': animals});
      }

      return Animal.fromJson(Map<String, dynamic>.from(animals.first as Map));
    } on DioException catch (error) {
      throw Exception(
        'The API request failed: '
        '${error.message ?? 'unknown error'}',
      );
    }
  }

  Future<String?> fetchRandomImage(String animal) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        'https://animals.maxz.dev/api/${Uri.encodeComponent(animal)}/random',
      );

      final image = response.data?['image'];
      return image is String && image.isNotEmpty ? image : null;
    } on DioException {
      return null;
    }
  }
}
