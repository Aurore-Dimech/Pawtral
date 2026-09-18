import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawtrol/src/services/auth_service.dart';

final authServiceProvider = Provider<AuthServices>((ref) {
  return AuthServices();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});