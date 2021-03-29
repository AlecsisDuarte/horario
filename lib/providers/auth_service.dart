import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// ignore: constant_identifier_names
enum AuthState { SignedIn, NotVerified, SignedUp, SignedOut }

class AuthService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  String? get displayName => FirebaseAuth.instance.currentUser?.displayName;
  String? get photoUrl => FirebaseAuth.instance.currentUser?.photoURL;
  String? get email => FirebaseAuth.instance.currentUser?.email;

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<AuthState> emailSignIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        return AuthState.SignedIn;
      } else {
        await user?.sendEmailVerification();
        return AuthState.NotVerified;
      }
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<AuthState> emailSignUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
      user?.updateProfile(displayName: name);
      return AuthState.SignedUp;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  String get userName {
    final User? user = FirebaseAuth.instance.currentUser;
    return user != null ? user.displayName ?? 'Student' : 'Student';
  }

  Future<void> updateName(String name) async {
    final User? user = FirebaseAuth.instance.currentUser;
    await user?.updateProfile(displayName: name);
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
