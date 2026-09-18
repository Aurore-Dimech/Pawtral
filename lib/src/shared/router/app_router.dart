import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawtrol/src/views/app/animals/animals_view.dart';
import 'package:pawtrol/src/views/app/animals/id/animal_view.dart';
import 'package:pawtrol/src/views/app/profile/profile_view.dart';
import 'package:pawtrol/src/views/app/scan/animal_test.dart';
import 'package:pawtrol/src/views/app/scan/firestore_test.dart';
import 'package:pawtrol/src/views/app/scan/isar_test.dart';
import 'package:pawtrol/src/views/app/scan/location_test.dart';
import 'package:pawtrol/src/views/auth/login_view.dart';
import 'package:pawtrol/src/views/auth/onboarding_view.dart';
import 'package:pawtrol/src/views/auth/register_view.dart';
import 'package:pawtrol/src/views/app/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawtrol/src/views/app/scan/picture_test.dart';
import 'package:pawtrol/src/views/app/scan/scan_view.dart';

import 'dart:async';

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
        GoRoute(path: 'login', builder: (context, state) => const LoginView()),
        GoRoute(
          path: 'register',
          builder: (context, state) => const RegisterView(),
        ),
      ],
    ),
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return Scaffold(
          body: child,
          /* ... */
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.add), label: 'New'),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Records'),
            ],
          ),
        );
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeView()),
        GoRoute(
          path: '/animals',
          builder: (context, state) => AnimalsView(),
          routes: [
            GoRoute(
              path: 'animal', // TODO: rendre l'argument dynamique
              builder: (context, state) => const AnimalView(),
            ),
          ],
        ),
        GoRoute(path: '/profile', builder: (context, state) => ProfileView()),
        GoRoute(
          path: '/picture-test',
          builder: (context, state) {
            return const PictureTestView();
          },
        ),
        GoRoute(
          path: '/localisation-test',
          builder: (context, state) {
            return const LocationTestView();
          },
        ),
        GoRoute(
          path: '/animal-test',
          builder: (context, state) {
            return const AnimalApiTestView();
          },
        ),
        GoRoute(
          path: '/isar-test',
          builder: (context, state) {
            return const IsarTestView();
          },
        ),
        GoRoute(
          path: '/firestore-test',
          builder: (context, state) {
            return const FirestoreTestView();
          },
        ),
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
