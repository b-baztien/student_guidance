import 'package:cloud_firestore/cloud_firestore.dart';

class Tcas {
  String round;
  String description;
  List<String> examReference;

  Tcas({this.round, this.description, this.examReference});

  factory Tcas.fromJson(Map<String, dynamic> json) {
    return Tcas(
        round: json['round'] as String,
        description: json['description'] as String,
        examReference: json['examReference'] as List<String>);
  }
}

class Major {
  String majorName;
  String url;
  List<Tcas> tcasEntranceRound;
  String certificate;
  String courseDuration;
  String tuitionFee;
  List<dynamic> career;
  DocumentReference faculty;

  Major(
      {this.majorName,
      this.url,
      this.tcasEntranceRound,
      this.certificate,
      this.courseDuration,
      this.tuitionFee,
      this.career,
      this.faculty});

  factory Major.fromJson(Map<String, dynamic> json) {
    return Major(
        majorName: json['majorName'] as String,
        // tcasEntranceRound: json['tcasEntranceRound'] as List<Tcas>,
        url: json['url'] as String,
        certificate: json['certificate'] as String,
        courseDuration: json['courseDuration'] as String,
        tuitionFee: json['courseDuration'] as String,
        career: json['career'] as List<dynamic>,
        faculty: json['faculty'] as DocumentReference);
  }
}
