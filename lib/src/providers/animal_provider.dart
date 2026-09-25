import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pawtrol/src/models/animal_model.dart';
import 'package:pawtrol/src/services/animal_service.dart';

import 'local_observation_provider.dart';

final animalServiceProvider = FutureProvider<AnimalService>((ref) async {
  final cacheService = await ref.watch(animalCacheServiceProvider.future);
  return AnimalService(cacheService: cacheService);
});

final animalProvider = FutureProvider.family<Animal, String>((
  ref,
  animal,
) async {
  final animalService = await ref.watch(animalServiceProvider.future);
  return animalService.fetchAnimal(animal);
});
