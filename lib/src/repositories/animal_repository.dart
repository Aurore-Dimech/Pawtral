import '../models/animal_model.dart';
import '../services/animal_service.dart';

class AnimalRepository {
  const AnimalRepository(this._service);

  final AnimalService _service;

  Future<Animal> findByName(String name) {
    return _service.fetchAnimal(name);
  }
}