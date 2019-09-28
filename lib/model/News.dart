import 'package:student_guidance/model/Teacher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class News {
   String topic;
   String detail;
   String image;
   DocumentReference teacher;
 
  News({this.detail,this.image,this.topic,this.teacher});
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      topic: json['topic'] as String,
     detail: json['detail'] as String,
      image: json['image'] as String,
      teacher : json['teacher'] as DocumentReference,
      
    );
  }
}
