import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taskmum_flutter/components/custom_exception.dart';
import 'package:taskmum_flutter/components/state_notifier/auth_controllar.dart';

abstract class BaseAuthRepository{
  Stream<User?> get authStateChanges;
  Future<void> signInAnonymously();
  User? getCurrentUser();
  Future<void> signOut();
}

final authRepositoryProvider =
    Provider<AuthRepository>((ref)  => AuthRepository(ref.read))

class AuthRepository implements BaseAuthRepository {
  final Reader _read;
  const AuthRepository(this._read)

  @override
  Stream<User?> get authStateChanges =>
      _read(firebaseAuthProvider).authStateChanges();

  @override
  Future<void> signInAnonymously() async {
    try {
      await _read(firebaseAuthProvider).signInAnonymously();
    }on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
    // await _read(firebaseAuthProvider).signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  User? getCurrentUser() {
    try {
      return _read(firebaseAuthProvider).currentUser;
    }on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signOut() async {
    await _read(firebaseAuthProvider).signOut();
    await signInAnonymously();
  }
}