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

    try {
      await synchronizePending();
    } catch (error, stackTrace) {
      debugPrint('Error: $error');
      debugPrintStack(stackTrace: stackTrace);
    }

    try {
      final remoteObservations = await firestoreService.getObservations(
        user.uid,
      );

      for (final observation in remoteObservations) {
        final animalName = observation['animalName'];
        final imagePath = observation['imagePath'];
        final remoteId = observation['remoteId'];
        final createdAt = observation['createdAt'];

        if (animalName is! String ||
            remoteId is! String ||
            imagePath is! String ||
            createdAt is! Timestamp) {
          continue;
        }

        try {
          await localRepository.saveRemoteObservation(
            remoteId: remoteId,
            userId: user.uid,
            animalName: animalName,
            imagePath: imagePath,
            createdAt: createdAt.toDate(),
            latitude: (observation['latitude'] as num?)?.toDouble(),
            longitude: (observation['longitude'] as num?)?.toDouble(),
          );
        } catch (error, stackTrace) {
          debugPrint('Error: $error');
          debugPrintStack(stackTrace: stackTrace);
        }
      }
    } catch (error, stackTrace) {
      debugPrint('Error: $error');
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
          remoteId: observation.remoteId,
          animalName: observation.animalName,
          imagePath: observation.imagePath,
          createdAt: observation.createdAt,
          latitude: observation.latitude,
          longitude: observation.longitude,
        );

        await localRepository.markAsSynchronized(observation.id);
      } catch (error, stackTrace) {
        debugPrint('Error: $error');
        debugPrintStack(stackTrace: stackTrace);
      }
    }
  }
}
