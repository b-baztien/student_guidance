import 'package:cloud_firestore/cloud_firestore.dart';

class Carrer{
  String carrer_name;
  List<dynamic> major;
  String description;
  String image;

  Carrer({
  this.carrer_name,this.major,this.description,this.image
  });
  factory Carrer.fromJson(Map<String, dynamic> json) {
    return Carrer(
     carrer_name: json['carrer_name'] as String,
      description: json['description'] as String,
       image: json['image'] as String,
      major: json['major'] as List<dynamic>,
    );
  }
}