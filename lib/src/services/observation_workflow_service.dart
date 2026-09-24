import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../repositories/local_observation_repository.dart';
import 'animal_ai_service.dart';
import 'animal_service.dart';
import 'firestore_service.dart';
import 'local_file_service.dart';
import 'location_service.dart';

import 'package:flutter/foundation.dart';

class ObservationWorkflowService {
  const ObservationWorkflowService({
    required this.animalAiService,
    required this.animalService,
    required this.firestoreService,
    required this.localFileService,
    required this.locationService,
    required this.localObservationRepository,
  });

  final AnimalAiService animalAiService;
  final AnimalService animalService;
  final FirestoreService firestoreService;
  final LocalFileService localFileService;
  final LocationService locationService;
  final LocalObservationRepository localObservationRepository;

  Future<ObservationDraft> analyzePicture({required XFile picture}) async {
    final localImage = await localFileService.copyToApplicationDirectory(
      picture,
    );
    final animalName = await animalAiService.identifyAnimal(localImage);
    await animalService.fetchAnimal(animalName);

    return ObservationDraft(animalName: animalName, imagePath: localImage.path);
  }

  Future<int> saveDraft({
    required ObservationDraft draft,
    required String userId,
  }) async {
    final position = await locationService.getCurrentPosition();
    final remoteId = const Uuid().v4();
    final observationId = await localObservationRepository.addObservation(
      remoteId: remoteId,
      userId: userId,
      animalName: draft.animalName,
      imagePath: draft.imagePath,
      latitude: position?.latitude,
      longitude: position?.longitude,
    );
    final observation = await localObservationRepository.getById(observationId);

    if (observation == null) {
      throw Exception('The local observation could not be found.');
    }

    try {
      await firestoreService.saveObservation(
        userId: userId,
        remoteId: remoteId,
        animalName: draft.animalName,
        imagePath: draft.imagePath,
        createdAt: observation.createdAt,
        latitude: position?.latitude,
        longitude: position?.longitude,
      );
      await localObservationRepository.markAsSynchronized(observationId);
    } catch (error, stackTrace) {
      debugPrint('Firestore synchronization failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }

    return observationId;
  }

  Future<int> processPicture({
    required XFile picture,
    required String userId,
  }) async {
    final draft = await analyzePicture(picture: picture);
    return saveDraft(draft: draft, userId: userId);
  }
}

class ObservationDraft {
  const ObservationDraft({required this.animalName, required this.imagePath});

  final String animalName;
  final String imagePath;
}
