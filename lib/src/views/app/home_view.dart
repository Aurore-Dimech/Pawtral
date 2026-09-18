import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Joke Generator')),
      body: SizedBox.expand(
        child: Column(
          children: [
            Text("home"),
            TextButton(
              onPressed: () => context.push('/picture-test'),
              child: Text("test nav"),
            ),
            TextButton(
              onPressed: () => context.push('/localisation-test'),
              child: Text("test nav"),
            ),
            TextButton.icon(
              onPressed: () {
                context.push('/animal-test');
              },
              icon: const Icon(Icons.cloud_download),
              label: const Text('Test animal API'),
            ),
            TextButton.icon(
              onPressed: () {
                context.push('/isar-test');
              },
              icon: const Icon(Icons.storage),
              label: const Text('Test offline storage'),
            ),
            TextButton.icon(
              onPressed: () {
                context.push('/firestore-test');
              },
              icon: const Icon(Icons.cloud_upload),
              label: const Text('Test Firestore'),
            ),
          ],
        ),
      ),
    );
  }
}
