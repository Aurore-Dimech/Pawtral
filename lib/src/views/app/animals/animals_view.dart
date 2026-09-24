import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        foregroundColor: AppColors.textColor,
        title: Text(
          'My animals',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: profile.when(
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

          return _AnimalsGrid(userId: userProfile.id);
        },
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
          padding: const EdgeInsets.all(16),
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