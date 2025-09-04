import 'dart:async';
import 'package:currensee/core/providers/firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currensee/features/auth/data/auth_repository.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

/// StreamProvider to listen to authentication state changes
final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(ref);
});

class AuthController extends StateNotifier<bool> {
  final Ref _ref;
  AuthController(this._ref) : super(false);

  Future<void> signIn(
      String email, String password, Function(String) onError) async {
    state = true;
    try {
      await _ref
          .read(authRepositoryProvider)
          .signInWithEmail(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? 'An unknown error occurred.');
    } finally {
      state = false;
    }
  }

  Future<void> signUp(
      String email, String password, Function(String) onError) async {
    state = true;
    try {
      await _ref
          .read(authRepositoryProvider)
          .signUpWithEmail(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? 'An unknown error occurred.');
    } finally {
      state = false;
    }
  }

  Future<void> signOut() async {
    await _ref.read(authRepositoryProvider).signOut();
  }
}
