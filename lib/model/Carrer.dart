import 'package:cloud_firestore/cloud_firestore.dart';

class Carrer{
  String carrer_name;
  List<dynamic> major;
  Carrer({
  this.carrer_name,this.major
  });
  factory Carrer.fromJson(Map<String, dynamic> json) {
    return Carrer(
     carrer_name: json['carrer_name'] as String,
      major: json['major'] as List<dynamic>,
    );
  }
}