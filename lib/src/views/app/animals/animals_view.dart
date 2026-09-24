import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pawtrol/src/data/local/animal_observation_entity.dart';
import 'package:pawtrol/src/widgets/date/date_converter.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/local_observation_provider.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../widgets/cards/animal_observation_card.dart';

class AnimalsView extends ConsumerWidget {
  const AnimalsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: profile.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              'Unable to load your animals.',
              style: TextStyle(color: AppColors.textColor),
            ),
          ),
          data: (userProfile) {
            if (userProfile == null) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }

            return SafeArea(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ImageFiltered(
                                imageFilter: ImageFilter.blur(
                                  sigmaX: 20,
                                  sigmaY: 20,
                                ),
                                child: Image.asset(
                                  'assets/images/Gallery.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                color: Colors.black.withValues(alpha: 0.25),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "My stats",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  _divider(),
                                  _AnimalStats(userId: userProfile.id),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    _AnimalsGrid(userId: userProfile.id),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AnimalsGrid extends ConsumerWidget {
  final String userId;

  const _AnimalsGrid({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final observations = ref.watch(localObservationsProvider(userId));

    return observations.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      ),
      error: (error, stackTrace) => Center(
        child: Text(
          'Unable to load your animals.',
          style: TextStyle(color: AppColors.textColor),
        ),
      ),
      data: (items) {
        if (items.isEmpty) {
          return Center(
            child: Text(
              'No animals photographed yet',
              style: TextStyle(color: AppColors.textColor),
            ),
          );
        }

        return MasonryGridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return AnimalObservationCard(observation: items[index]);
          },
        );
      },
    );
  }
}

class _AnimalStats extends ConsumerWidget {
  final String userId;

  const _AnimalStats({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final observations = ref.watch(localObservationsProvider(userId));

    return observations.when(
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const Text('Unable to load stats'),
      data: (items) {
        final uniqueAnimals = items.isEmpty
            ? 0
            : items.map((item) => item.animalName).toSet().length;
        final lastObservation = items.isEmpty ? null : items.first;
        final firstObservation = items.isEmpty ? null : items.last;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${items.isEmpty ? 0 : items.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'animals discovered',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 12),
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
                    children: [
                      Text(
                        '$uniqueAnimals',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'unique species found',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            _divider(),

            _statContainer(
              label: "First animal seen: ",
              observation: firstObservation,
              characteristic: firstObservation?.animalName,
            ),
            _statContainer(
              label: "Spotted on: ",
              observation: firstObservation,
              date: firstObservation?.createdAt,
            ),

            _divider(),

            _statContainer(
              label: "Last animal seen: ",
              observation: lastObservation,
              characteristic: lastObservation?.animalName,
            ),
            _statContainer(
              label: "Spotted on: ",
              observation: lastObservation,
              date: lastObservation?.createdAt,
            ),
          ],
        );
      },
    );
  }
}

Widget _divider() {
  return const Divider(
    thickness: 1,
    height: 40,
    indent: 24,
    endIndent: 24,
    color: Colors.white54,
  );
}

Widget _statContainer({
  required String label,
  AnimalObservationEntity? observation,
  String? characteristic,
  DateTime? date,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(label, style: TextStyle(fontSize: 12, color: Colors.white70)),
      if (observation != null) ...[
        if (characteristic != null)
          Text(
            characteristic,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

        if (date != null)
          DateConverter(
            date: date,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    ],
  );
}
