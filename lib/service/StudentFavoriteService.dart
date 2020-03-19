import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/StudentFavorite.dart';
import 'package:student_guidance/utils/UIdata.dart';

CollectionReference ref = Firestore.instance.collection("Student");

class StudentFavoriteService {
  Future<List<StudentFavorite>> getStudentFavoriteByUsername(
      String username) async {
    try {
      Query query = Firestore.instance
          .collectionGroup('StudentFavorite')
          .where('username', isEqualTo: username);
      List<StudentFavorite> listFavorite =
          await query.getDocuments().then((doc) async {
        return doc.documents
            .map((snapshot) => StudentFavorite.fromJson(snapshot.data))
            .toList();
      });
      return listFavorite;
    } catch (e) {
      rethrow;
    }
  }

  addStudentFavorite(StudentFavorite favorite) async {
    try {
      SharedPreferences preferences = await UIdata.getPrefs();
      Login login = Login.fromJson(jsonDecode(preferences.getString('login')));
      favorite.username = login.username;
      Firestore.instance
          .collectionGroup('Login')
          .where('username', isEqualTo: login.username)
          .getDocuments()
          .then((loginDoc) async {
        if (loginDoc.documents[0] == null) return;
        await loginDoc.documents[0].reference
            .parent()
            .parent()
            .collection('StudentFavorite')
            .add(favorite.toMap());
      });
    } catch (e) {
      rethrow;
    }
  }

  deleteStudentFavorite(StudentFavorite favorite) async {
    try {
      SharedPreferences preferences = await UIdata.getPrefs();
      Login login = Login.fromJson(jsonDecode(preferences.getString('login')));
      favorite.username = login.username;
      Firestore.instance
          .collectionGroup('StudentFavorite')
          .where('university', isEqualTo: favorite.university)
          .where('faculty', isEqualTo: favorite.faculty)
          .where('major', isEqualTo: favorite.major)
          .where('username', isEqualTo: login.username)
          .getDocuments()
          .then((favoriteDoc) async {
        if (favoriteDoc.documents[0] == null) return;
        await favoriteDoc.documents[0].reference.delete();
      });
    } catch (e) {
      rethrow;
    }
  }
}
