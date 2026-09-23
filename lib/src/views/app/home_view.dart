import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pawtrol/src/data/local/animal_observation_entity.dart';
import 'package:pawtrol/src/models/user_model.dart';
import 'package:pawtrol/src/providers/auth_provider.dart';
import 'package:pawtrol/src/providers/animal_provider.dart';
import 'package:pawtrol/src/providers/local_observation_provider.dart';
import 'package:pawtrol/src/shared/theme/app_colors.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    return profile.when(
      loading: () => const _HomeLoadingScreen(),
      error: (error, stackTrace) => _HomeErrorScreen(error: error),
      data: (userProfile) {
        if (userProfile == null) {
          return const _HomeLoadingScreen();
        }
        return _HomeContent(userProfile: userProfile);
      },
    );
  }
}

class _HomeLoadingScreen extends StatelessWidget {
  const _HomeLoadingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      ),
    );
  }
}

class _HomeErrorScreen extends StatelessWidget {
  final Object error;

  const _HomeErrorScreen({required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Unable to load your profile.\nPlease try again later.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textColor),
          ),
        ),
      ),
    );
  }
}

class _HomeContent extends ConsumerWidget {
  final AppUser userProfile;

  const _HomeContent({required this.userProfile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final observations = ref.watch(localObservationsProvider(userProfile.id));

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 400,
              child: ClipPath(
                clipper: HeaderContainer(),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/Home.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: EdgeInsetsGeometry.directional(
                          start: 32,
                          end: 20,
                          top: 20,
                          bottom: 80,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withValues(alpha: 0.08),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.2,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hi ${userProfile.name}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        'Welcome back!',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),

                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withValues(alpha: 0.08),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.2,
                                      ),
                                    ),
                                  ),
                                  child: observations.when(
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    error: (error, stackTrace) => const Text(
                                      'Unable to load observations',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    data: (items) {
                                      final lastObservation = items.isEmpty
                                          ? null
                                          : items.first;

                                      return IntrinsicHeight(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${items.length}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 32,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Text(
                                                    'animals photographed',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            const VerticalDivider(
                                              width: 24,
                                              thickness: 1,
                                              color: Colors.white24,
                                            ),

                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    lastObservation
                                                            ?.animalName ??
                                                        'None',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 32,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Text(
                                                    'is the last animal seen',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsetsGeometry.only(top: 0, right: 20, left: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'My animals',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textColor,
                          ),
                        ),

                        TextButton(
                          onPressed: () => context.push('/animals'),
                          child: Row(
                            children: [
                              Text(
                                "See all",
                                style: TextStyle(
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 12,
                                color: AppColors.secondaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Find here all the animals you identified so far',
                      style: TextStyle(color: AppColors.textColor),
                    ),

                    const SizedBox(height: 16),

                    observations.when(
                      loading: () => const SizedBox(
                        height: 220,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      error: (error, stackTrace) =>
                          const _AnimalCarousel(recent: []),
                      data: (items) {
                        final recent = items.take(10).toList();
                        return _AnimalCarousel(recent: recent);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimalCarousel extends StatelessWidget {
  final List<AnimalObservationEntity> recent;

  const _AnimalCarousel({required this.recent});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.72),
        padEnds: false,
        itemCount: recent.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.only(right: 12),
              child: _AddObservationCard(),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _AnimalObservationCard(observation: recent[index - 1]),
          );
        },
      ),
    );
  }
}

class _AddObservationCard extends StatelessWidget {
  const _AddObservationCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/scan'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            border: Border.all(
              color: AppColors.primaryColor.withValues(alpha: 0.4),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor.withValues(alpha: 0.15),
                ),
                child: const Icon(
                  Icons.add_a_photo_rounded,
                  size: 28,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Add an observation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimalObservationCard extends StatelessWidget {
  final AnimalObservationEntity observation;

  const _AnimalObservationCard({required this.observation});

  @override
  Widget build(BuildContext context) {
    final String animalName = observation.animalName;
    final imagePath = observation.imagePath;

    return GestureDetector(
      onTap: () {
        context.push('/animals', extra: animalName);
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 160,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: _ObservationImage(
                  animalName: animalName,
                  imagePath: imagePath,
                ),
              ),
            ),

            SizedBox(
              height: 42,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    animalName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
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

class HeaderContainer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
