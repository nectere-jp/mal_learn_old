import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  UserInfo(this.user) {
    setUserInfo();
  }

  void setUserInfo() async {
    final document = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    displayName = document['displayName'] as String;
    birthDay = document['birthdDay'] is Timestamp ? document['birthdDay'] : null;
    iconUrl = document['iconUrl'];
  }

  late final User user;
  late final String? displayName;
  late final DateTime? birthDay;
  late final String? iconUrl;
}
