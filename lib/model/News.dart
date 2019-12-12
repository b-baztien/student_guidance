import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  String topic;
  String detail;
  String image;
  Timestamp startTime;
  DocumentReference teacher;

  News({this.detail, this.image, this.topic, this.startTime, this.teacher});
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      topic: json['topic'] as String,
      detail: json['detail'] as String,
      image: json['image'] as String,
      startTime: json['start_time'] as Timestamp,
      teacher: json['teacher'] as DocumentReference,
    );
  }
}
