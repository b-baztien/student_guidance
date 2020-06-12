import 'package:cloud_firestore/cloud_firestore.dart';

class Tcas {
  Timestamp startDate;
  Timestamp endDate;
  String round;
  int entranceAmount;
  String url;

  Tcas(
      {this.startDate,
      this.endDate,
      this.round,
      this.entranceAmount,
      this.url});

  factory Tcas.fromJson(Map<String, dynamic> json) {
    return Tcas(
      startDate: json['startDate'] as Timestamp,
      endDate: json['endDate'] as Timestamp,
      round: json['round'] as String,
      entranceAmount:
          json['entranceAmount'] == null ? 0 : json['entranceAmount'] as int,
      url: json['url'] as String,
    );
  }
}
