import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Login.dart';

CollectionReference ref = Firestore.instance.collection("Login");

class LoginService {
  Future<Login> login(Login user_login) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DocumentReference refQuery = await ref.document(user_login.username);

      Login login = await refQuery.get().then((doc) async {
        return Login.fromJson(doc.data);
      });
      if (login.type == 'student') {
        if (user_login.password == login.password) {
          prefs.setString('login', jsonEncode(user_login.toMap()));
          return await login;
        } else {}
      } else {
        throw ("ไม่ใช่นักเรียน");
      }
    } catch (e) {
      rethrow;
    }
  }
}
