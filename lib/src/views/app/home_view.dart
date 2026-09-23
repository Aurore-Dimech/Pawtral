import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pawtrol/src/models/user_model.dart';
import 'package:pawtrol/src/providers/auth_provider.dart';
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
    final observations = ref.watch(localObservationsProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header:
          SizedBox(
            height: 400,
            child: ClipPath(
              clipper: HeaderContainer(),
              child: Stack(
                children: [
                  // Background image:
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/Home.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Content:
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
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withValues(alpha: 0.08),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.2),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withValues(alpha: 0.08),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.2),
                                  ),
                                ),
                                child: observations.when(
                                  loading: () => const Center(
                                    child: CircularProgressIndicator(),
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
                                                    fontWeight: FontWeight.bold,
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
                                                  lastObservation?.animalName ??
                                                      'None',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.bold,
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

          // Main:
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
                        onPressed: () => context.push('/gallery'),
                        child: Row(
                          children: [
                            Text(
                              "See all",
                              style: TextStyle(color: AppColors.secondaryColor),
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
                    'Find here all the animals you found in your time with us',
                    style: TextStyle(color: AppColors.textColor),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.push('/scan');
                    },
                    icon: const Icon(Icons.add_a_photo),
                    label: const Text('New observation'),
                  ),
                ],
              ),
            ),
          ),
        ],
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
    return true;
  }
}