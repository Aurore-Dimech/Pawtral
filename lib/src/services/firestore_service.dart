import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<List<Map<String, dynamic>>> getObservations(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('observations')
        .get();

    return snapshot.docs.map((document) => document.data()).toList();
  }

  Future<void> saveObservation({
    required String userId,
    required String observationId,
    required String animalName,
    required String imagePath,
    required DateTime createdAt,
    double? latitude,
    double? longitude,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('observations')
        .doc(observationId)
        .set({
          'animalName': animalName,
          'imagePath': imagePath,
          'latitude': latitude,
          'longitude': longitude,
          'createdAt': Timestamp.fromDate(createdAt),
          'synchronizedAt': FieldValue.serverTimestamp(),
        });
  }
}
