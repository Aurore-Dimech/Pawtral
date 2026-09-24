import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../providers/observation_workflow_provider.dart';
import '../../../services/picture_service.dart';
import '../../../shared/theme/app_colors.dart';

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
  bool _isError = false;

  Future<void> _chooseFromGallery() async {
    final picture = await _pictureService.pickFromGallery();

    if (!mounted || picture == null) {
      return;
    }

    setState(() {
      _picture = picture;
      _message = null;
      _isError = false;
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
      _isError = false;
    });
  }

  Future<void> _processPicture() async {
    final picture = _picture;
    final user = FirebaseAuth.instance.currentUser;

    if (picture == null) {
      setState(() {
        _message = 'Choose or take a picture first.';
        _isError = true;
      });
      return;
    }

    if (user == null) {
      setState(() {
        _message = 'You must be logged in.';
        _isError = true;
      });
      return;
    }

    setState(() {
      _isProcessing = true;
      _message = null;
      _isError = false;
    });

    try {
      // TODO: remplacer par redirection vers la page Animal sur laquelle il y a un bouton pour sauvegarder l'animal
      final workflow = await ref.read(observationWorkflowProvider.future);

      await workflow.processPicture(picture: picture, userId: user.uid);

      if (!mounted) {
        return;
      }

      setState(() {
        _message = 'Animal saved locally and synchronization attempted.';
        _isError = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _message = error.toString().replaceFirst('Exception: ', '');
        _isError = true;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  void _reset() {
    setState(() {
      _picture = null;
      _isProcessing = false;
      _message = null;
      _isError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        foregroundColor: AppColors.textColor,
        title: Text(
          'New observation',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: _picture == null
                    ? const _EmptyPicturePlaceholder()
                    : _PicturePreview(
                        imagePath: _picture!.path,
                        isProcessing: _isProcessing,
                      ),
              ),
              const SizedBox(height: 16),
              if (_message != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _MessageBanner(
                    message: _message!,
                    isError: _isError,
                  ),
                ),
              if (!_isError && _message != null)
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: _reset,
                    child: Text(
                      'Scan another animal',
                      style: TextStyle(color: AppColors.secondaryColor),
                    ),
                  ),
                )
              else
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed:
                                _isProcessing ? null : _takePicture,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primaryColor,
                              side: BorderSide(
                                color: AppColors.primaryColor,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            icon: const Icon(Icons.camera_alt_rounded),
                            label: const Text('Camera'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed:
                                _isProcessing ? null : _chooseFromGallery,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primaryColor,
                              side: BorderSide(
                                color: AppColors.primaryColor,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            icon: const Icon(Icons.photo_library_rounded),
                            label: const Text('Gallery'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isProcessing ? null : _processPicture,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: const Icon(Icons.pets_rounded),
                        label: const Text('Analyze and save'),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyPicturePlaceholder extends StatelessWidget {
  const _EmptyPicturePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor.withValues(alpha: 0.15),
            ),
            child: const Icon(
              Icons.pets_rounded,
              size: 36,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Take or choose a photo of the animal you found',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textColor, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

class _PicturePreview extends StatelessWidget {
  final String imagePath;
  final bool isProcessing;

  const _PicturePreview({
    required this.imagePath,
    required this.isProcessing,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(File(imagePath), fit: BoxFit.cover),
          if (isProcessing) ...[
            Container(color: Colors.black.withValues(alpha: 0.45)),
            const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: AppColors.primaryColor),
                  SizedBox(height: 16),
                  Text(
                    'Identifying the animal...',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MessageBanner extends StatelessWidget {
  final String message;
  final bool isError;

  const _MessageBanner({required this.message, required this.isError});

  @override
  Widget build(BuildContext context) {
    final color = isError ? Colors.redAccent : AppColors.primaryColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            isError ? Icons.error_outline_rounded : Icons.check_circle_rounded,
            color: color,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: AppColors.textColor, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}