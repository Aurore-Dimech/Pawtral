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
    );
  }
}
