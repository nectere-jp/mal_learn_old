import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  Future<void> addUser(
    String email,
    String password,
    String nickname,
    File icon,
  ) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}