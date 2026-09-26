import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<List<Map<String, dynamic>>> getObservations(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('observations')
          .get();

      return snapshot.docs.map((document) {
        return {...document.data(), 'remoteId': document.id};
      }).toList();
    } catch (error, stackTrace) {
      debugPrint('Error: $error');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> saveObservation({
    required String userId,
    required String remoteId,
    required String animalName,
    required String imagePath,
    required DateTime createdAt,
    double? latitude,
    double? longitude,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('observations')
          .doc(remoteId)
          .set({
            'remoteId': remoteId,
            'animalName': animalName,
            'imagePath': imagePath,
            'latitude': latitude,
            'longitude': longitude,
            'createdAt': Timestamp.fromDate(createdAt),
            'synchronizedAt': FieldValue.serverTimestamp(),
          });
    } catch (error, stackTrace) {
      debugPrint('Error: $error');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }
}
