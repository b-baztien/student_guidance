import 'package:cloud_firestore/cloud_firestore.dart';

class Tcas {
  Timestamp startDate;
  Timestamp endDate;
  String round;
  int entranceAmount;
  int examFee;
  // score: TcasScore[] = new Array<TcasScore>();
  String registerPropertie;
  String remark;

  Tcas(
      {this.startDate,
      this.endDate,
      this.round,
      this.entranceAmount,
      this.examFee,
      this.registerPropertie,
      this.remark});

  factory Tcas.fromJson(Map<String, dynamic> json) {
    return Tcas(
      startDate: json['startDate'] as Timestamp,
      endDate: json['endDate'] as Timestamp,
      round: json['round'] as String,
      entranceAmount:
          json['entranceAmount'] == null ? 0 : json['entranceAmount'] as int,
      examFee: json['examFee'] == null ? 0 : json['examFee'] as int,
      registerPropertie: json['registerPropertie'] as String,
      remark: json['remark'] as String,
    );
  }
}
