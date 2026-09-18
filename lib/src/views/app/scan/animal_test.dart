import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/animal_provider.dart';

class AnimalApiTestView extends ConsumerStatefulWidget {
  const AnimalApiTestView({super.key});

  @override
  ConsumerState<AnimalApiTestView> createState() {
    return _AnimalApiTestViewState();
  }
}

class _AnimalApiTestViewState extends ConsumerState<AnimalApiTestView> {
  final TextEditingController _animalController = TextEditingController(
    text: 'fox',
  );

  String? _searchedAnimal;

  @override
  void dispose() {
    _animalController.dispose();
    super.dispose();
  }

  void _searchAnimal() {
    final animalName = _animalController.text.trim().toLowerCase();

    if (animalName.isEmpty) {
      return;
    }

    setState(() {
      _searchedAnimal = animalName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchedAnimal = _searchedAnimal;

    return Scaffold(
      appBar: AppBar(title: const Text('Animal API test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _animalController,
              decoration: const InputDecoration(
                labelText: 'Animal name',
                hintText: 'Example: fox',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _searchAnimal,
                icon: const Icon(Icons.search),
                label: const Text('Search animal'),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: searchedAnimal == null
                  ? const Center(
                      child: Text('Enter an animal name and press search.'),
                    )
                  : _AnimalResult(animalName: searchedAnimal),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimalResult extends ConsumerWidget {
  const _AnimalResult({required this.animalName});

  final String animalName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animalState = ref.watch(animalProvider(animalName));

    return animalState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text(
          'Unable to load animal.\n$error',
          textAlign: TextAlign.center,
        ),
      ),
      data: (animal) {
        return ListView(
          children: [
            Text(
              animal.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text('Locations: ${animal.locations.join(', ')}'),
            const SizedBox(height: 8),
            Text(
              'Scientific name: '
              '${animal.taxonomy.scientificName}',
            ),
            const SizedBox(height: 8),
            Text(
              'Habitat: '
              '${animal.characteristics.habitat}',
            ),
            const SizedBox(height: 8),
            Text('Diet: ${animal.characteristics.diet}'),
          ],
        );
      },
    );
  }
}
