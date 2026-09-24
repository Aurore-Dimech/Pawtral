import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(
  AuthController.new,
);

class AuthController extends AsyncNotifier<void> {
  @override
  void build() {}

  Future<void> login({required String email, required String password}) async {
    if (email.trim().isEmpty || password.isEmpty) {
      throw Exception('Please complete all fields.');
    }

    await _run(
      () => ref.read(authServiceProvider).signInWithEmail(email, password),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (name.trim().isEmpty || email.trim().isEmpty || password.isEmpty) {
      throw Exception('Please complete all fields.');
    }
    if (password != confirmPassword) {
      throw Exception('Passwords do not match.');
    }

    await _run(() async {
      final credential = await ref
          .read(authServiceProvider)
          .signUpWithEmail(email, password);
      final user = credential?.user;

      if (user == null) {
        throw Exception('The account could not be created.');
      }

      await ref
          .read(authServiceProvider)
          .saveProfileInformation(
            userId: user.uid,
            name: name,
            email: email,
            createdAt: DateTime.now(),
          );
    });
  }

  Future<void> deleteAccount() async {
    await _run(() => ref.read(authServiceProvider).deleteAccount());
  }

  Future<void> reauthenticateAndDeleteAccount({
    required String password,
  }) async {
    await _run(
      () => ref
          .read(authServiceProvider)
          .reauthenticateAndDeleteAccount(password: password),
    );
  }

  Future<void> signOut() async {
    await _run(() => ref.read(authServiceProvider).signOut());
  }

  Future<void> _run(Future<void> Function() action) async {
    state = const AsyncLoading();
    try {
      await action();
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}
