import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/firestore_provider.dart';
import '../../../providers/local_observation_provider.dart';

class FirestoreTestView extends ConsumerStatefulWidget {
  const FirestoreTestView({super.key});

  @override
  ConsumerState<FirestoreTestView> createState() {
    return _FirestoreTestViewState();
  }
}

class _FirestoreTestViewState extends ConsumerState<FirestoreTestView> {
  bool _isSaving = false;
  String? _message;

  Future<void> _saveObservation() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      setState(() {
        _message = 'You must be logged in.';
      });
      return;
    }

    setState(() {
      _isSaving = true;
      _message = null;
    });

    try {
      final observations = await ref.read(localObservationsProvider.future);

      if (observations.isEmpty) {
        throw Exception('No local observation to synchronize.');
      }

      final observation = observations.first;
      final firestoreService = ref.read(firestoreServiceProvider);

      await firestoreService.saveObservation(
        userId: user.uid,
        observationId: observation.id.toString(),
        animalName: observation.animalName,
        imagePath: observation.imagePath,
        createdAt: observation.createdAt,
        latitude: observation.latitude,
        longitude: observation.longitude,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _message = 'Observation synchronized with Firestore.';
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _message = 'Synchronization failed: $error';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firestore test')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isSaving)
                const CircularProgressIndicator()
              else
                ElevatedButton.icon(
                  onPressed: _saveObservation,
                  icon: const Icon(Icons.cloud_upload),
                  label: const Text('Synchronize fox'),
                ),
              const SizedBox(height: 20),
              if (_message != null)
                Text(_message!, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
