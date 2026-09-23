import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawtrol/src/shared/theme/app_colors.dart';
import 'package:pawtrol/src/widgets/slider_button.dart/slider_button.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  double _contentOpacity = 1.0;
  final int _transitionDuration = 400;

  Future<void> _openLogin() async {
    setState(() {
      _contentOpacity = 0.0;
    });

    await Future.delayed(Duration(milliseconds: _transitionDuration));

    if (!mounted) {
      return;
    }

    context.go('/auth/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background image:
          Positioned.fill(
            child: Image.asset(
              'assets/images/OnBoarding.png',
              fit: BoxFit.cover,
            ),
          ),

          // Gradient:
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 600,
            child: AnimatedOpacity(
              opacity: _contentOpacity,
              duration: Duration(milliseconds: _transitionDuration),
              curve: Curves.easeOut,
              child: Column(
                children: [
                  Container(
                    height: 240,
                    color: Colors.white.withValues(alpha: 0.95),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withValues(alpha: 0.95),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content:
          AnimatedOpacity(
            opacity: _contentOpacity,
            duration: Duration(milliseconds: _transitionDuration),
            curve: Curves.easeOut,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 60),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.pets_outlined,
                            size: 40,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(height: 12),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Discover all ",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: "about "),
                                TextSpan(
                                  text: "the animals",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: "' world"),
                              ],
                            ),
                            style: TextStyle(
                              fontSize: 32,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w300,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Take pictures of all the animals that share your life, learn about them, and add them to your collection!',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SliderButton(
                      onSlided: _openLogin,
                      text: 'Start your pawtrol',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
