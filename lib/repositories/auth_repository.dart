import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  Future<void> addUser({
    required String email,
    required String password,
    required String nickname,
    required File icon,
    required DateTime birthday,
  }) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    final String uid = FirebaseAuth.instance.currentUser!.uid;

    final String name = icon.path.split('/').last;

    final TaskSnapshot task = await FirebaseStorage.instance
        .ref()
        .child('users/$uid')
        .child('icon_$name')
        .putFile(icon);

    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'nickname': nickname,
      'birthday': Timestamp.fromDate(birthday),
      'iconPath': task.ref.getDownloadURL(),
    });
  }
}

final userRepository = UserRepository();
