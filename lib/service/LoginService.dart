import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Login.dart';

CollectionReference ref = Firestore.instance.collection("Login");

class LoginService {
  Future<Login> login(Login userLogin) async {
    Login login;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Query query = Firestore.instance
          .collectionGroup('Login')
          .where('username', isEqualTo: userLogin.username);

      await query.getDocuments().then((snapshot) async {
        if (snapshot.documents.isNotEmpty) {
          login = Login.fromJson(snapshot.documents.first.data);

          if (login.type == 'student' || login.type == 'alumni') {
            if (userLogin.password == login.password) {
              prefs.setString('login', jsonEncode(login.toMap()));

              //get student
              prefs.setString(
                  'student',
                  jsonEncode((await snapshot.documents.first.reference
                          .parent()
                          .parent()
                          .get())
                      .data));

              //get schoolName
              prefs.setString(
                  'schoolId',
                  snapshot.documents.first.reference
                      .parent()
                      .parent()
                      .parent()
                      .parent()
                      .documentID
                      .trim());
            } else {
              throw ("ชื่อผู้ใช้ หรือ รหัสผ่านไม่ถูกต้อง");
            }
          } else {
            throw ("ไม่ใช่นักเรียน");
          }
        } else {
          throw ("ชื่อผู้ใช้ หรือ รหัสผ่านไม่ถูกต้อง");
        }
      });
    } catch (e) {
      clearLoginData();
      rethrow;
    }
    return login;
  }

  clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time') == null
        ? true
        : prefs.getBool('first_time');
    prefs.clear();
    prefs.setBool('first_time', firstTime);
  }
}
