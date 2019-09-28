import 'package:cloud_firestore/cloud_firestore.dart';

import 'Login.dart';

class Teacher extends Login {
  String firstname;
  String lastname;
  String phoneNO;
  String email;
  String photo;
  DocumentReference login;
  DocumentReference school;


  Teacher({this.firstname,this.lastname,this.phoneNO,this.email,this.photo,this.login,this.school});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
     firstname: json['firstname'] as String,
     lastname: json['lastname'] as String,
     phoneNO: json['phone_no'] as String,
     email: json['email'] as String,
      photo: json['photo'] as String,
      login: json['Login'] as DocumentReference,
      school: json['School'] as DocumentReference,
      
    );
  }
}