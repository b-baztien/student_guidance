import 'package:cloud_firestore/cloud_firestore.dart';

class Faculty{
  String facultyName;
  String url;
  DocumentReference university;
  Faculty({
    this.facultyName,this.url,this.university
  });
  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
     facultyName: json['faculty_name'] as String,
     url: json['url'] as String,
     university: json['university'] as DocumentReference,
    );
  }
}