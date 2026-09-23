import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../repositories/local_observation_repository.dart';
import 'firestore_service.dart';

class ObservationSyncService {
  const ObservationSyncService({
    required this.localRepository,
    required this.firestoreService,
  });

  final LocalObservationRepository localRepository;
  final FirestoreService firestoreService;

  Future<void> synchronize() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    await synchronizePending();

    try {
      final remoteObservations = await firestoreService.getObservations(
        user.uid,
      );

      for (final observation in remoteObservations) {
        final animalName = observation['animalName'];
        final imagePath = observation['imagePath'];
        final createdAt = observation['createdAt'];

        if (animalName is! String ||
            imagePath is! String ||
            createdAt is! Timestamp) {
          continue;
        }

        await localRepository.saveRemoteObservation(
          userId: user.uid,
          animalName: animalName,
          imagePath: imagePath,
          createdAt: createdAt.toDate(),
          latitude: (observation['latitude'] as num?)?.toDouble(),
          longitude: (observation['longitude'] as num?)?.toDouble(),
        );
      }

    } catch (error, stackTrace) {
      debugPrint('Firestore observation download failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> synchronizePending() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    final observations = await localRepository.getUnsynchronizedObservations(
      user.uid,
    );

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
