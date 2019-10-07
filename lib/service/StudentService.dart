import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/Student.dart';
CollectionReference ref = Firestore.instance.collection("Student");
class StudentService{
 Future<Student> getStudent() async {
    try {
       final prefs = await SharedPreferences.getInstance();
         Map<String, dynamic> jsonLogin = jsonDecode(prefs.get('login'));
          Login  login = Login.fromJson(jsonLogin);
      DocumentReference refQuery = await ref.document(login.username);
        Student student = await refQuery.get().then((doc) async {
        return Student.fromJson(doc.data);
      });
      return await student;
   
    } catch (e) {
      rethrow;
    }
  }
}