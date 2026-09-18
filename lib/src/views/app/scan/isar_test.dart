import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/local_observation_provider.dart';

class IsarTestView extends ConsumerWidget {
  const IsarTestView({super.key});

  Future<void> _saveObservation(WidgetRef ref) async {
    final repository =
        await ref.read(localObservationRepositoryProvider.future);

    await repository.addObservation(
      animalName: 'fox',
      imagePath: 'local-test-image.jpg',
      latitude: 48.8566,
      longitude: 2.3522,
    );

    ref.invalidate(localObservationsProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final observations = ref.watch(localObservationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Isar offline test'),
      ),
      body: observations.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            'Unable to load observations.\n$error',
            textAlign: TextAlign.center,
          ),
        ),
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text('No local observations'),
            );
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final observation = items[index];

              return ListTile(
                leading: const Icon(Icons.pets),
                title: Text(observation.animalName),
                subtitle: Text(
                  observation.createdAt.toLocal().toString(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await _saveObservation(ref);
        },
        icon: const Icon(Icons.save),
        label: const Text('Save fox'),
      ),
    );
  }
}