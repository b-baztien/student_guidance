import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/Student.dart';

class RegisterService {
  Future<void> register(String schoolName, Student student, Login login) async {
    try {
      await Firestore.instance
          .collectionGroup('Login')
          .where('username', isEqualTo: login.username)
          .getDocuments()
          .then((value) {
        if (value.documents.isNotEmpty) {
          throw ('มีชื่อผู้ใช้ ' + login.username + ' อยู่ในระบบแล้ว !');
        }
      });

      await Firestore.instance
          .collection('School')
          .document(schoolName)
          .collection('Student')
          .document(login.username)
          .setData(student.toMap());

      await Firestore.instance
          .collection('School')
          .document(schoolName)
          .collection('Student')
          .document(login.username)
          .collection('Login')
          .document(login.username)
          .setData(login.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
