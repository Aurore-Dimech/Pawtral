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
              onPressed: () => context.push('/auth'),
              child: Text("test nav"),
            ),
          ],
        ),
      ),
    );
  }
}
