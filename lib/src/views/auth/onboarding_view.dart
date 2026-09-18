import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background:
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.white, Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ).createShader(bounds),
          blendMode: BlendMode.lighten,
          child: Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/OnBoarding.png"),
                fit: BoxFit.cover,
                // colorFilter: ColorFilter.mode(Colors.white, BlendMode.lighten),
              ),
            ),
          ),
        ),

        // Content:
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pawtral", style: TextStyle(fontSize: 24)),
                        Text(
                          "Prenez en photo les animaux que vous rencontrez, et rajoutez les à votre collection personnelle !",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                TextButton(
                  style: ButtonStyle(),
                  onPressed: () => context.push('/auth/login'),
                  child: Text("Se connecter"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
