import 'package:cloud_firestore/cloud_firestore.dart';

class Faculty{
  String facultyName;
  String url;
  DocumentReference university;
  List<dynamic> major;
  Faculty({
    this.facultyName,this.url,this.university,this.major
  });
  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
     facultyName: json['faculty_name'] as String,
     url: json['url'] as String,
     university: json['university'] as DocumentReference,
      major: json['major'] as List<dynamic>,
    );
  }
}