import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String studentID;
  String firstName;
  String lastName;
  String email;
  String gender;
  String entryYear;
  String image;
  String juniorSchool;
  String phone;
  String status;
  String plan;

  Student({
    this.studentID,
    this.firstName,
    this.lastName,
    this.email,
    this.entryYear,
    this.gender,
    this.image,
    this.juniorSchool,
    this.phone,
    this.plan,
    this.status,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      firstName: json['firstname'] as String,
      lastName: json['lastname'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      entryYear: json['entry_year'] as String,
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
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'gender': gender,
      'entry_year': entryYear,
      'image': image,
      'junior_school': juniorSchool,
      'phone_no': phone,
      'student_status': status,
      'study_plan': plan,
      'student_id': studentID,
    };
  }
}
