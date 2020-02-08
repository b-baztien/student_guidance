import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Teacher.dart';

class TeacherService {
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

  Stream<List<Teacher>> getAllTeacherBySchoolName(String schoolName) {
    Query query = Firestore.instance
        .collection('School')
        .document(schoolName)
        .collection('Teacher')
        .orderBy('position')
        .orderBy('firstname')
        .orderBy('lastname');

    return query.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Teacher.fromJson(doc.data))
          .toList();
    });
  }
}
