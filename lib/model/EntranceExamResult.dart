import 'package:cloud_firestore/cloud_firestore.dart';

class EntranceExamResult {
  String entrance_exam_name;
  DocumentReference school;
  String round;
  String year;
  DocumentReference student;
  DocumentReference university;
  DocumentReference faculty;
  DocumentReference major;
  EntranceExamResult(
      {this.entrance_exam_name,
      this.school,
      this.round,
      this.year,
      this.university,
      this.faculty,
      this.major,
      this.student});
  Map toMap() {
    var map = Map<String, dynamic>();
    map['entrance_exam_name'] = entrance_exam_name;
    map['school'] = school;
    map['year'] = year;
    map['student'] = student;

    map['university'] = university;
    map['faculty'] = faculty;
    map['major'] = major;
    return map;
  }

  factory EntranceExamResult.fromJson(Map<String, dynamic> json) {
    return EntranceExamResult(
      entrance_exam_name: json['entrance_exam_name'] as String,
      school: json['school'] as DocumentReference,
      year: json['year'] as String,
      university: json['university'] as DocumentReference,
      faculty: json['faculty'] as DocumentReference,
      major: json['major'] as DocumentReference,
      student: json['student'] as DocumentReference,
    );
  }
}
