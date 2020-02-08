import 'package:cloud_firestore/cloud_firestore.dart';

import 'Login.dart';

class Teacher extends Login {
  String firstname;
  String lastname;
  String phoneNO;
  String email;
  String image;
  String position;

  Teacher(
      {this.firstname,
      this.lastname,
      this.phoneNO,
      this.email,
      this.image,
      this.position});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      phoneNO: json['phone_no'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
      position: json['position'] as String,
    );
  }
}
