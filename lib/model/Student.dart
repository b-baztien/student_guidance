import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String studentID;
  String firstname;
  String lastname;
  String email;
  String gender;
  String entryyear;
  String image;
  String juniorSchool;
  String phone;
  String status;
  String plan;
  Student({
    this.studentID,
    this.firstname,
    this.lastname,
    this.email,
    this.entryyear,
    this.gender,
    this.image,
    this.juniorSchool,
    this.phone,
    this.plan,
    this.status,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      entryyear: json['entry_year'] as String,
      image: json['image'] as String,
      juniorSchool: json['junior_school'] as String,
      phone: json['phone_no'] as String,
      status: json['student_status'] as String,
      plan: json['study_plan'] as String,
      studentID: json['student_id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'gender': gender,
      'entry_year': entryyear,
      'image': image,
      'junior_school': juniorSchool,
      'phone_no': phone,
      'student_status': status,
      'study_plan': plan,
      'student_id': studentID,
    };
  }
}
