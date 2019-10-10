import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/Student.dart';

CollectionReference ref = Firestore.instance.collection("Student");

class StudentService {
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
