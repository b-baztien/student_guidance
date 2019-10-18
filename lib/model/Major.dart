import 'package:cloud_firestore/cloud_firestore.dart';

class Major{
  String majorName;
  String url;
  String entrancedetail;
  List<dynamic> carrer;
  DocumentReference faculty;
  Major(
    {
     this.majorName,this.url,this.faculty,this.carrer,this.entrancedetail
    }
  );

  factory Major.fromJson(Map<String, dynamic> json) {
    return Major(
      majorName: json['major_name'] as String,
     entrancedetail: json['entrance_detail'] as String,
      url: json['url'] as String,
      faculty : json['faculty'] as  DocumentReference,
       carrer : json['carrer'] as  List<dynamic>,
    );
  }
}