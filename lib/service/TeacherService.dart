import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Teacher.dart';

class TeacherService{
  Future<Teacher> getTeacher(DocumentReference doc) async {
    try {
      DocumentReference refQuery = doc;
      Teacher teacher = await refQuery.get().then((doc) async {
        return Teacher.fromJson(doc.data);
      });
      return teacher;
    } catch (e) {
      rethrow;
    }
  }
}