import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<int> processPicture({
    required XFile picture,
    required String userId,
  }) async {
    final localImage = await localFileService.copyToApplicationDirectory(
      picture,
    );

    final animalName = await animalAiService.identifyAnimal(localImage);

    await animalService.fetchAnimal(animalName);

    final position = await locationService.getCurrentPosition();

    final observationId = await localObservationRepository.addObservation(
      animalName: animalName,
      imagePath: localImage.path,
      latitude: position?.latitude,
      longitude: position?.longitude,
    );

    try {
      await firestoreService.saveObservation(
        userId: userId,
        observationId: observationId.toString(),
        animalName: animalName,
        imagePath: localImage.path,
        createdAt: DateTime.now(),
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
}
