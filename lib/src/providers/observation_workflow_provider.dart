import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/animal_ai_service.dart';
import '../services/animal_service.dart';
import '../services/firestore_service.dart';
import '../services/local_file_service.dart';
import '../services/location_service.dart';
import '../services/observation_workflow_service.dart';
import 'animal_provider.dart';
import 'firestore_provider.dart';
import 'local_observation_provider.dart';

final animalAiServiceProvider = Provider<AnimalAiService>((ref) {
  return AnimalAiService();
});

final localFileServiceProvider = Provider<LocalFileService>((ref) {
  return LocalFileService();
});

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

final observationWorkflowProvider =
    FutureProvider<ObservationWorkflowService>((ref) async {
  final repository =
      await ref.watch(localObservationRepositoryProvider.future);

  return ObservationWorkflowService(
    animalAiService: ref.watch(animalAiServiceProvider),
    animalService: ref.watch(animalServiceProvider),
    firestoreService: ref.watch(firestoreServiceProvider),
    localFileService: ref.watch(localFileServiceProvider),
    locationService: ref.watch(locationServiceProvider),
    localObservationRepository: repository,
  );
});