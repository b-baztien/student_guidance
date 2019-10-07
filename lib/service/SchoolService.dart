import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/School.dart';

class SchoolService{
   Future<School> getSchool(DocumentReference doc) async {
    try {
      DocumentReference refQuery = doc;
      School school = await refQuery.get().then((doc) async {
        return School.fromJson(doc.data);
      });
      return school;
    } catch (e) {
      rethrow;
    }
  }
}