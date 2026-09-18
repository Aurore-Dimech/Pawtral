import 'package:dio/dio.dart';
import '../models/animal_model.dart';

class AnimalService {
  final Dio _dio;

  AnimalService({Dio? dio}) : _dio = dio ?? Dio();

  Future<Animal> fetchAnimal(String animal) async {
    final response = await _dio.get<Map<String, Object?>>(
      'https://api.api-ninjas.com/v1/animals?name=$animal',
    );

    if (response.data == null) {
      throw Exception('No data');
    }

    return Animal.fromJson(response.data!);
  }
}
