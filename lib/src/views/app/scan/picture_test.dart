import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/picture_service.dart';

class PictureTestView extends StatefulWidget {
  const PictureTestView({super.key});

  @override
  State<PictureTestView> createState() => _PictureTestViewState();
}

class _PictureTestViewState extends State<PictureTestView> {
  final PictureService _pictureService = PictureService();

  XFile? _selectedPicture;

  Future<void> _takePicture() async {
    final picture = await _pictureService.takePicture();

    if (!mounted || picture == null) {
      return;
    }

    setState(() {
      _selectedPicture = picture;
    });
  }

  Future<void> _pickFromGallery() async {
    final picture = await _pictureService.pickFromGallery();

    if (!mounted || picture == null) {
      return;
    }

    setState(() {
      _selectedPicture = picture;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test picture'),
      ),
      body: Center(
        child: _selectedPicture == null
            ? const Text('No picture selected')
            : Image.file(
                File(_selectedPicture!.path),
                width: 280,
                height: 280,
                fit: BoxFit.cover,
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _takePicture,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Camera'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _pickFromGallery,
                icon: const Icon(Icons.photo),
                label: const Text('Gallery'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}