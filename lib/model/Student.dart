import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String studentID;
  String firstname;
  String lastname;
  String email;
  String gender;
  String entryyear;
  DocumentReference school;
  List<DocumentReference> entranceExamResult;
  List<DocumentReference> favoriteCarrer;
  List<DocumentReference> favoriteUniversity;
  String image;
  String juniorSchool;
  String phone;
  String status;
  String plan;
  DocumentReference login;
  Student({this.studentID,this.firstname,this.lastname,this.email
  ,this.entryyear,this.gender,this.image,this.school,
  this.juniorSchool,this.phone,this.plan,this.status,this.entranceExamResult,this.favoriteCarrer,this.favoriteUniversity,this.login});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
     firstname: json['firstname'] as String,
     lastname: json['lastname'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      entryyear: json['entry_year'] as String,
      school: json['school'] as DocumentReference,
      image: json['image'] as String,
      juniorSchool: json['junior_school'] as String,
      phone: json['phone_no'] as String,
      status: json['student_status'] as String,
      plan: json['study_plan'] as String,
       studentID: json['student_id'] as String,
      entranceExamResult: json['entrance_exam_result'] as List<DocumentReference>,
      favoriteCarrer: json['favorite_carrer'] as List<DocumentReference>,
      favoriteUniversity: json['favorite_university'] as List<DocumentReference>,
      login: json['login'] as DocumentReference,

    );
  }

  



}