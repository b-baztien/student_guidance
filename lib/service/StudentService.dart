import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/Student.dart';

CollectionReference ref = Firestore.instance.collection("Student");

class StudentService {
  Stream<Student> getStudentByUsername(String username) {
    Stream<QuerySnapshot> studentSnapshot =
        Firestore.instance.collectionGroup('Student').snapshots();
    return studentSnapshot.map((stuSnapshot) {
      Student student;
      for (var doc in stuSnapshot.documents) {
        if (doc.documentID == username) {
          student = Student.fromJson(doc.data);
        }
      }
      return student;
    });
  }

  Future<bool> editStudentProfile(String username, Student student) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result;
    try {
      Future<QuerySnapshot> studentSnapshot =
          Firestore.instance.collectionGroup('Student').getDocuments();
      await studentSnapshot.then((stuSnapshot) async {
        for (var stuDoc in stuSnapshot.documents) {
          if (stuDoc.documentID == username) {
            await stuDoc.reference.setData(student.toMap());
            result = true;
            sharedPreferences.setString('student', jsonEncode(student.toMap()));
          }
        }
      });
    } catch (error) {
      result = false;
      rethrow;
    }
    return result;
  }

//not use
  Future<Student> getStudent() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      Map<String, dynamic> jsonLogin = jsonDecode(prefs.get('login'));
      Login login = Login.fromJson(jsonLogin);
      DocumentReference refQuery = ref.document(login.username);
      Student student = await refQuery.get().then((doc) async {
        return Student.fromJson(doc.data);
      });
      return student;
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentReference> getStudentReference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> jsonLogin = jsonDecode(prefs.get('login'));
      Login login = Login.fromJson(jsonLogin);
      DocumentReference refQuery = ref.document(login.username);
      return refQuery;
    } catch (e) {
      rethrow;
    }
  }
}
