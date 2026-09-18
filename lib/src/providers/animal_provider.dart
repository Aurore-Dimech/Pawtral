import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pawtrol/src/models/animal_model.dart';
import 'package:pawtrol/src/services/animal_service.dart';

final animalServiceProvider = Provider<AnimalService>((ref) {
  return AnimalService();
});

final animalProvider = FutureProvider.family<Animal, String>((ref, animal) async {
  final animalService = ref.watch(animalServiceProvider);
  return animalService.fetchAnimal(animal);
});