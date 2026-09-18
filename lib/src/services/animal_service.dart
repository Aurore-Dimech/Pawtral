import 'package:dio/dio.dart';

import '../models/animal_model.dart';

class AnimalService {
  AnimalService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<Animal> fetchAnimal(String name) async {
    final response = await _dio.get<List<dynamic>>(
      'https://api.api-ninjas.com/v1/animals',
      queryParameters: {'name': name},
      options: Options(
        headers: {
          'X-Api-Key': const String.fromEnvironment(
            'ANIMAL_API_KEY',
          ),
        },
      ),
    );

    final animals = response.data;

    if (animals == null || animals.isEmpty) {
      throw Exception('Animal not found');
    }

    return Animal.fromJson(
      animals.first as Map<String, dynamic>,
    );
  }
}