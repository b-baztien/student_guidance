import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Login.dart';

CollectionReference ref = Firestore.instance.collection("Login");

class LoginService {
  Future<Login> login(Login userLogin) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DocumentReference refQuery = ref.document(userLogin.username);

      Login login = await refQuery.get().then((doc) async {
        if (doc.exists) {
          return Login.fromJson(doc.data);
        } else {
          throw ("ชื่อผู้ใช้ หรือ รหัสผ่านไม่ถูกต้อง");
        }
      });

      if (login.type == 'student') {
        if (userLogin.password == login.password) {
          prefs.setString('login', jsonEncode(login.toMap()));
          return login;
        } else {
          throw ("ชื่อผู้ใช้ หรือ รหัสผ่านไม่ถูกต้อง");
        }
      } else {
        throw ("ไม่ใช่นักเรียน");
      }
    } catch (e) {
      rethrow;
    }
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
