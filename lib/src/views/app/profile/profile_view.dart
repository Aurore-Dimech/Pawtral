import 'package:flutter/material.dart';
import 'package:pawtrol/src/services/auth_service.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text('Profile')),
          ElevatedButton(
            onPressed: () => AuthServices().signOut(),
            child: Text("Sign out"),
          ),
        ],
      ),
    );
  }
}
