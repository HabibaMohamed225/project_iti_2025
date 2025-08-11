import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AtuthRpo {}

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(name);

      return credential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed To Sign In : ${e.toString()}');
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
