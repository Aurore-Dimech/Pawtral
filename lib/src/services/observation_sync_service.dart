import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/local_observation_repository.dart';
import 'firestore_service.dart';

import 'package:flutter/foundation.dart';

class ObservationSyncService {
  const ObservationSyncService({
    required this.localRepository,
    required this.firestoreService,
  });

  final LocalObservationRepository localRepository;
  final FirestoreService firestoreService;

  Future<void> synchronizePending() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    final observations = await localRepository.getUnsynchronizedObservations();

    for (final observation in observations) {
      try {
        await firestoreService.saveObservation(
          userId: user.uid,
          observationId: observation.id.toString(),
          animalName: observation.animalName,
          imagePath: observation.imagePath,
          createdAt: observation.createdAt,
          latitude: observation.latitude,
          longitude: observation.longitude,
        );

        await localRepository.markAsSynchronized(observation.id);
      } catch (error, stackTrace) {
        debugPrint(
          'Pending observation ${observation.id} failed to synchronize: $error',
        );
        debugPrintStack(stackTrace: stackTrace);
      }
    }
  }
}
