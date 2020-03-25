import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/StudentRecommend.dart';
import 'package:student_guidance/utils/UIdata.dart';

CollectionReference ref = Firestore.instance.collection("Student");

class StudentRecommendService {
  Future<StudentRecommend> getStudentRecommendByUsername() async {
    try {
      SharedPreferences preferences = await UIdata.getPrefs();
      Login login = Login.fromJson(jsonDecode(preferences.getString('login')));
      Query query = Firestore.instance
          .collectionGroup('StudentRecommend')
          .where('username', isEqualTo: login.username);
      StudentRecommend reccommend =
          await query.getDocuments().then((doc) async {
        return doc.documents.isEmpty
            ? null
            : StudentRecommend.fromJson(doc.documents[0].data);
      });
      return reccommend;
    } catch (e) {
      rethrow;
    }
  }

  addEditStudentRecommend(StudentRecommend recommend) async {
    try {
      SharedPreferences preferences = await UIdata.getPrefs();
      Login login = Login.fromJson(jsonDecode(preferences.getString('login')));
      recommend.username = login.username;
      Firestore.instance
          .collectionGroup('Login')
          .where('username', isEqualTo: login.username)
          .getDocuments()
          .then((loginDoc) async {
        if (loginDoc.documents[0] == null) return;
        await Firestore.instance
            .collection(loginDoc.documents[0].reference
                .parent()
                .parent()
                .collection('StudentRecommend')
                .path)
            .getDocuments()
            .then((recDoc) async {
          recDoc.documents.isNotEmpty
              ? recDoc.documents[0].reference.updateData(recommend.toMap())
              : await loginDoc.documents[0].reference
                  .parent()
                  .parent()
                  .collection('StudentRecommend')
                  .add(recommend.toMap());
        });
      });
    } catch (e) {
      rethrow;
    }
  }
}
