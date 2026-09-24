import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pawtrol/src/widgets/date/date_converter.dart';

import '../../data/local/animal_observation_entity.dart';
import '../../providers/animal_provider.dart';
import '../../shared/theme/app_colors.dart';

class AnimalObservationCard extends StatelessWidget {
  final AnimalObservationEntity observation;

  const AnimalObservationCard({super.key, required this.observation});

  @override
  Widget build(BuildContext context) {
    final String animalName = observation.animalName;
    final imagePath = observation.imagePath;

    return GestureDetector(
      onTap: () {
        context.push('/animals/detail', extra: animalName);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 1.3,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _ObservationImage(
                        animalName: animalName,
                        imagePath: imagePath,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      animalName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    DateConverter(
                      date: observation.createdAt,
                      text: "Spotted on",
                    ),
                    const SizedBox(height: 6),
                    _ObservationSyncStatus(
                      isSynchronized: observation.isSynchronized,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ObservationImage extends ConsumerStatefulWidget {
  final String animalName;
  final String? imagePath;

  const _ObservationImage({required this.animalName, required this.imagePath});

  @override
  ConsumerState<_ObservationImage> createState() => _ObservationImageState();
}

class _ObservationImageState extends ConsumerState<_ObservationImage> {
  String? _remoteImageUrl;
  bool _remoteImageRequested = false;

  @override
  void initState() {
    super.initState();
    if (widget.imagePath == null || widget.imagePath!.isEmpty) {
      _requestRemoteImage();
    } else {
      _checkLocalImage();
    }
  }

  Future<void> _checkLocalImage() async {
    if (!await File(widget.imagePath!).exists() && mounted) {
      _requestRemoteImage();
    }
  }

  Future<void> _requestRemoteImage() async {
    if (_remoteImageRequested) {
      return;
    }

    _remoteImageRequested = true;
    final imageUrl = await ref
        .read(animalServiceProvider)
        .fetchRandomImage(widget.animalName);

    if (mounted && imageUrl != null) {
      setState(() {
        _remoteImageUrl = imageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_remoteImageUrl != null) {
      return Image.network(
        _remoteImageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallback(),
      );
    }

    if (widget.imagePath == null || widget.imagePath!.isEmpty) {
      return _buildFallback();
    }

    return Image.file(
      File(widget.imagePath!),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        _requestRemoteImage();
        return _buildFallback();
      },
    );
  }

  Widget _buildFallback() {
    return Container(
      color: AppColors.secondaryColor.withValues(alpha: 0.15),
      child: const Center(
        child: Icon(
          Icons.pets_rounded,
          size: 40,
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }
}

class _ObservationSyncStatus extends StatelessWidget {
  final bool isSynchronized;

  const _ObservationSyncStatus({required this.isSynchronized});

  @override
  Widget build(BuildContext context) {
    final color = isSynchronized ? Colors.green : Colors.orange;
    final label = isSynchronized
        ? 'Saved locally - synchronized'
        : 'Saved locally - waiting for sync';

    return Row(
      children: [
        Icon(
          isSynchronized
              ? Icons.cloud_done_rounded
              : Icons.cloud_upload_rounded,
          size: 14,
          color: color,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 11, color: color),
          ),
        ),
      ],
    );
  }
}
