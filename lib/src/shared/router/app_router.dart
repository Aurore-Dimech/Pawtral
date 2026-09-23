import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawtrol/src/views/app/animals/animals_view.dart';
import 'package:pawtrol/src/views/app/animals/id/animal_view.dart';
import 'package:pawtrol/src/views/app/error/error_view.dart';
import 'package:pawtrol/src/views/app/profile/profile_view.dart';
import 'package:pawtrol/src/views/auth/auth_view.dart';
import 'package:pawtrol/src/views/auth/onboarding_view.dart';
import 'package:pawtrol/src/views/app/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawtrol/src/views/app/scan/scan_view.dart';

import 'dart:async';

import 'package:pawtrol/src/widgets/navigation/bottom-nav-bar.dart';

class AuthRefreshNotifier extends ChangeNotifier {
  AuthRefreshNotifier() {
    _subscription = FirebaseAuth.instance.authStateChanges().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<User?> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final authRefreshNotifier = AuthRefreshNotifier();

final appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: authRefreshNotifier,
  errorBuilder: (context, state) => ErrorView(error: state.error),
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final isAuthRoute = state.uri.path.startsWith('/auth');

    if (!isLoggedIn && !isAuthRoute) {
      return '/auth';
    }

    if (isLoggedIn && isAuthRoute) {
      return '/';
    }

    return null;
  },

  routes: [
    GoRoute(
      path: '/auth',
      builder: (context, state) => const OnboardingView(),
      routes: [
        GoRoute(path: 'login', builder: (context, state) => const AuthView()),
      ],
    ),
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return AppBottomNavigationBar(location: state.uri.path, child: child);
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeView()),
        GoRoute(
          path: '/animals',
          builder: (context, state) => AnimalsView(),
          routes: [
            GoRoute(
              path: 'animal',
              builder: (context, state) {
                // final animal = state.extra as Animal;
                // return const AnimalView(animal: animal);
                return const AnimalView();
              },
            ),
          ],
        ),
        GoRoute(path: '/profile', builder: (context, state) => ProfileView()),
        GoRoute(
          path: '/scan',
          builder: (context, state) {
            return const ScanView();
          },
        ),
      ],
    ),
  ],
);
