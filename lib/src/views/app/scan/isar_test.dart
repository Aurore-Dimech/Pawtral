import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/local_information_provider.dart';

class IsarTestView extends ConsumerWidget {
  const IsarTestView({super.key});

  Future<void> _saveInformation(WidgetRef ref) async {
    final repository =
        await ref.read(localInformationRepositoryProvider.future);

    await repository.addInformation(
      animalName: 'fox',
      imagePath: 'local-test-image.jpg',
      latitude: 48.8566,
      longitude: 2.3522,
    );

    ref.invalidate(localInformationProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final information = ref.watch(localInformationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Isar offline test'),
      ),
      body: information.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            'Unable to load information.\n$error',
            textAlign: TextAlign.center,
          ),
        ),
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text('No local information'),
            );
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final information = items[index];

              return ListTile(
                leading: const Icon(Icons.pets),
                title: Text(information.animalName),
                subtitle: Text(
                  information.createdAt.toLocal().toString(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await _saveInformation(ref);
        },
        icon: const Icon(Icons.save),
        label: const Text('Save fox'),
      ),
    );
  }
}