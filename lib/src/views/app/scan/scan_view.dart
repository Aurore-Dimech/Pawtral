import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/scan_controller.dart';
import '../../../shared/theme/app_colors.dart';

class ScanView extends ConsumerWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanState = ref.watch(scanControllerProvider);

    return scanState.when(
      loading: () => _buildContent(context, ref, const ScanState(), true),
      error: (error, stackTrace) =>
          _buildContent(context, ref, const ScanState(), false, error: error),
      data: (state) => _buildContent(context, ref, state, false),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    ScanState state,
    bool isLoading, {
    Object? error,
  }) {
    final controller = ref.read(scanControllerProvider.notifier);
    final picture = state.picture;
    final message = error?.toString().replaceFirst('Exception: ', '');

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: const BackButton(),
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
                child: picture == null
                    ? const _EmptyPicturePlaceholder()
                    : _PicturePreview(
                        imagePath: picture.path,
                        isProcessing: state.isProcessing || isLoading,
                      ),
              ),
              const SizedBox(height: 16),
              if (message != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _MessageBanner(message: message, isError: true),
                ),
              if (message != null)
                TextButton(
                  onPressed: controller.reset,
                  child: const Text('Try again'),
                ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: state.isProcessing
                          ? null
                          : controller.takePicture,
                      icon: const Icon(Icons.camera_alt_rounded, color: AppColors.primaryColor,),
                      label: const Text('Camera', style: TextStyle(color: AppColors.primaryColor),),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: state.isProcessing
                          ? null
                          : controller.chooseFromGallery,
                      icon: const Icon(Icons.photo_library_rounded, color: AppColors.primaryColor),
                      label: const Text('Gallery', style: TextStyle(color: AppColors.primaryColor)),
                    ),
                  ),
                ],
              ),
              if (picture != null) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: state.isProcessing
                        ? null
                        : () async {
                            final draft = await controller.analyzePicture();
                            if (context.mounted && draft != null) {
                              context.push('/animals/detail', extra: draft);
                            }
                          },
                    icon: const Icon(Icons.pets_rounded),
                    label: const Text('Analyze'),
                  ),
                ),
              ],
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

  const _PicturePreview({required this.imagePath, required this.isProcessing});

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
