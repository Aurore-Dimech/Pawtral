import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../providers/observation_workflow_provider.dart';
import '../../../services/picture_service.dart';

class ScanView extends ConsumerStatefulWidget {
  const ScanView({super.key});

  @override
  ConsumerState<ScanView> createState() {
    return _ScanViewState();
  }
}

class _ScanViewState extends ConsumerState<ScanView> {
  final PictureService _pictureService = PictureService();

  XFile? _picture;
  bool _isProcessing = false;
  String? _message;

  Future<void> _chooseFromGallery() async {
    final picture = await _pictureService.pickFromGallery();

    if (!mounted || picture == null) {
      return;
    }

    setState(() {
      _picture = picture;
      _message = null;
    });
  }

  Future<void> _takePicture() async {
    final picture = await _pictureService.takePicture();

    if (!mounted || picture == null) {
      return;
    }

    setState(() {
      _picture = picture;
      _message = null;
    });
  }

  Future<void> _processPicture() async {
    final picture = _picture;
    final user = FirebaseAuth.instance.currentUser;

    if (picture == null) {
      setState(() {
        _message = 'Choose or take a picture first.';
      });
      return;
    }

    if (user == null) {
      setState(() {
        _message = 'You must be logged in.';
      });
      return;
    }

    setState(() {
      _isProcessing = true;
      _message = null;
    });

    try {
      // TODO: remplacer par redirection vers la page Animal sur laquelle il y a un bouton pour sauvegarder l'animal
      final workflow =
          await ref.read(observationWorkflowProvider.future);

      await workflow.processPicture(
        picture: picture,
        userId: user.uid,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _message =
            'Animal saved locally and synchronization attempted.';
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _message = error.toString().replaceFirst(
              'Exception: ',
              '',
            );
      });
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New observation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: _picture == null
                  ? const Center(
                      child: Text('No picture selected'),
                    )
                  : Image.file(
                      File(_picture!.path),
                      fit: BoxFit.contain,
                    ),
            ),
            if (_message != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  _message!,
                  textAlign: TextAlign.center,
                ),
              ),
            if (_isProcessing)
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: CircularProgressIndicator(),
              ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isProcessing
                        ? null
                        : _takePicture,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isProcessing
                        ? null
                        : _chooseFromGallery,
                    icon: const Icon(Icons.photo),
                    label: const Text('Gallery'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isProcessing
                    ? null
                    : _processPicture,
                icon: const Icon(Icons.pets),
                label: const Text('Analyze and save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}