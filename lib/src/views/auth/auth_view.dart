import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pawtrol/src/providers/auth_provider.dart';
import 'package:pawtrol/src/shared/theme/app_colors.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  double opacity = 0;

  bool isLoading = false;
  String? errorMessage;

  final tabs = ["Sign in", "Sign up"];
  int _activeTab = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        opacity = 1;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final authService = ref.read(authServiceProvider);

      await authService.signInWithEmail(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (mounted) {
        context.go('/');
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          errorMessage = error.toString().replaceFirst('Exception: ', '');
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> register() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final authService = ref.read(authServiceProvider);

      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final name = nameController.text.trim();
      final confirmPassword = confirmPasswordController.text.trim();

      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        setState(() {
          errorMessage = 'Please complete all fields.';
          isLoading = false;
        });
        return;
      }

      if (password != confirmPassword) {
        throw Exception('Passwords do not match.');
      }

      final userCredential = await authService.signUpWithEmail(email, password);

      final user = userCredential?.user;

      if (user == null) {
        throw Exception('The account could not be created.');
      }

      await authService.saveProfileInformation(
        userId: user.uid,
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );

      if (mounted) {
        context.go('/');
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          errorMessage = error.toString().replaceFirst('Exception: ', '');
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image:
          Positioned.fill(
            child: Image.asset(
              'assets/images/OnBoarding.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsetsGeometry.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(tabs.length, (index) {
                            final isSelected = _activeTab == index;
                            return tag(index, isSelected);
                          }),
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                    child: _activeTab == 0
                        ? _buildSignInForm()
                        : _buildSignUpForm(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black26),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black38),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      floatingLabelStyle: const TextStyle(color: AppColors.primaryColor),
    );
  }

  Widget tag(int index, bool isActive) {
    final borderRadius = BorderRadius.circular(40);

    final button = TextButton(
      onPressed: () {
        setState(() {
          _activeTab = index;
        });
      },
      style: TextButton.styleFrom(
        backgroundColor: isActive
            ? AppColors.primaryColor
            : AppColors.backgroundColor,
        foregroundColor: isActive ? Colors.white : AppColors.textColor,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
      child: Text(tabs[index]),
    );

    return button;
  }

  Widget textInput({
    required TextEditingController controller,
    TextInputType? keyboardType,
    required InputDecoration decoration,
    bool? obscureText,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.textColor),
      cursorColor: AppColors.primaryColor,
      decoration: decoration,
    );
  }

  Widget _buildSignInForm() {
    return _buildFormContainer(
      children: [
        textInput(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: _inputDecoration('Email'),
        ),
        textInput(
          controller: passwordController,
          obscureText: true,
          decoration: _inputDecoration('Password'),
        ),

        if (errorMessage != null)
          Text(errorMessage!, style: const TextStyle(color: Colors.red)),
        SizedBox(height: 32),
        ElevatedButton(
          onPressed: isLoading ? null : login,
          style: ElevatedButton.styleFrom(
            backgroundColor: isLoading
                ? AppColors.primaryColor.withValues(alpha: 0.5)
                : AppColors.primaryColor,
          ),
          child: Container(
            child: Center(
              child: isLoading
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : const Text('Login', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return _buildFormContainer(
      children: [
        textInput(
          controller: nameController,
          keyboardType: TextInputType.name,
          decoration: _inputDecoration('Name'),
        ),
        textInput(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: _inputDecoration('Email'),
        ),
        textInput(
          controller: passwordController,
          obscureText: true,
          decoration: _inputDecoration('Password'),
        ),
        textInput(
          controller: confirmPasswordController,
          obscureText: true,
          decoration: _inputDecoration('Confirm password'),
        ),

        if (errorMessage != null)
          Text(errorMessage!, style: const TextStyle(color: Colors.red)),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: isLoading ? null : register,
          style: ElevatedButton.styleFrom(
            backgroundColor: isLoading
                ? AppColors.primaryColor.withValues(alpha: 0.5)
                : AppColors.primaryColor,
          ),
          child: Container(
            child: Center(
              child: isLoading
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : const Text(
                      'Create account',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormContainer({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.backgroundColor,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}
