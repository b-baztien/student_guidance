import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Teacher.dart';

class TeacherService {
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

  Stream<Map<String, List<Teacher>>> getAllMapTeacherBySchoolName(
      String schoolName) {
    Query collectionReference = Firestore.instance
        .collection('School')
        .document(schoolName)
        .collection('Teacher')
        .orderBy('position')
        .orderBy('firstname')
        .orderBy('lastname');

    return collectionReference.snapshots().map((snapshot) {
      Map<String, List<Teacher>> mapTeacher = new Map();
      snapshot.documents.forEach((docChange) {
        String positionMapKey = docChange.data['position'];

        List<Teacher> listTeacher = new List();
        snapshot.documents.forEach((doc) {
          if (positionMapKey == doc.data['position']) {
            listTeacher.add(Teacher.fromJson(doc.data));
          }
        });
        mapTeacher[positionMapKey] = listTeacher;
      });

      return mapTeacher;
    });
  }
}
