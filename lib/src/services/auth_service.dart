import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawtrol/src/models/user_model.dart';

class ReauthenticationRequiredException implements Exception {
  const ReauthenticationRequiredException();
}

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore;

  AuthServices({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    try {
      final userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCred;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      final userCred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCred;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  Exception _handleFirebaseError(FirebaseAuthException e) {
    debugPrint('Firebase error code: ${e.code}');
    switch (e.code) {
      case 'invalid-email':
        return Exception('The email address is not valid.');
      case 'user-disabled':
        return Exception('This account has been disabled.');
      case 'user-not-found':
        return Exception('No user found with this email.');
      case 'wrong-password':
      case 'invalid-credential':
      case 'INVALID_LOGIN_CREDENTIALS':
        return Exception('Incorrect password or email. Please try again.');
      case 'too-many-requests':
        return Exception('Too many requests. Please try again later.');
      case 'user-token-expired':
        return Exception('Session expired. Please log in again.');
      case 'network-request-failed':
        return Exception('No internet connection. Please check your network.');
      case 'email-already-in-use':
        return Exception('This email is already registered. Try Logging In.');
      case 'weak-password':
        return Exception('Password should be at least 6 characters.');
      case 'operation-not-allowed':
        return Exception('Email/password sign-in is not enabled.');
      default:
        return Exception('Something went wrong. Please try again.');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> saveProfileInformation({
    required String userId,
    required String name,
    required String email,
    required DateTime createdAt,
  }) async {
    await _firestore.collection('users').doc(userId).set({
      'name': name,
      'email': email,
      'createdAt': Timestamp.fromDate(createdAt),
      'synchronizedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<AppUser?> getProfileInformation(String userId) async {
    final document = await _firestore.collection('users').doc(userId).get();

    final data = document.data();

    if (data == null) {
      return null;
    }

    return AppUser.fromFirestore(document.id, data);
  }

  Future<void> deleteAccount() async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is currently signed in.');
    }

    try {
      await _deleteAccountData(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw const ReauthenticationRequiredException();
      }
      throw _handleFirebaseError(e);
    }
  }

  Future<void> reauthenticateAndDeleteAccount({
    required String password,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is currently signed in.');
    }

    final email = user.email;

    if (email == null) {
      throw Exception(
        'This account has no email on file, so it cannot be re-authenticated this way.',
      );
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);
      await _deleteAccountData(user);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  Future<void> _deleteAccountData(User user) async {
    await _firestore.collection('users').doc(user.uid).delete();
    await user.delete();
  }
}