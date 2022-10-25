import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? role;
  String? uid;

// receiving data
  UserModel({this.uid, this.email, this.role});
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      role: map['role'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'Role': role,
    };
  }
}
