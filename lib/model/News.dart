import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  String topic;
  String detail;
  String image;
  Timestamp startTime;
  List listUniversityName;

  News(
      {this.detail,
      this.image,
      this.topic,
      this.startTime,
      this.listUniversityName});
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      topic: json['topic'] as String,
      detail: json['detail'] as String,
      image: json['image'] as String,
      startTime: json['start_time'] as Timestamp,
      listUniversityName: json['listUniversity_name'],
    );
  }
}
