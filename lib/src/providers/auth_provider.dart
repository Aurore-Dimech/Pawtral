import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawtrol/src/models/user_model.dart';
import 'package:pawtrol/src/services/auth_service.dart';

final authServiceProvider = Provider<AuthServices>((ref) {
  return AuthServices();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final currentUserProvider = Provider<User?>((ref) {
  return switch (ref.watch(authStateProvider)) {
    AsyncData(:final value) => value,
    _ => null,
  };
});

final profileProvider = FutureProvider<AppUser?>((ref) async {
  final user = ref.watch(currentUserProvider);

  if (user == null) {
    return null;
  }

  final authService = ref.watch(authServiceProvider);

  return authService.getProfileInformation(user.uid);
});
