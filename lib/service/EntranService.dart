import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/EntranceExamResult.dart';
import 'package:student_guidance/model/EntranceMajor.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/utils/UIdata.dart';

class EntranService {
  Future<List<EntranceExamResult>> getAllEntranceExamResult() async {
    List<DocumentSnapshot> templist;
    List<EntranceExamResult> list = new List();
    CollectionReference collectionReference =
        Firestore.instance.collection('EntranceExamResult');

    QuerySnapshot collecttionSnapshot =
        await collectionReference.getDocuments();
    templist = collecttionSnapshot.documents;
    list = templist.map((DocumentSnapshot doc) {
      return EntranceExamResult.fromJson(doc.data);
    }).toList();
    return list;
  }

  Future<bool> addEntranceExamResult(EntranceExamResult enExam) async {
    try {
      SharedPreferences preferences = await UIdata.getPrefs();
      Login login = Login.fromJson(jsonDecode(preferences.getString('login')));
      return Firestore.instance
          .collectionGroup('Login')
          .where('username', isEqualTo: login.username)
          .getDocuments()
          .then((loginDoc) async {
        if (loginDoc.documents[0] == null) return false;
        await loginDoc.documents[0].reference
            .parent()
            .parent()
            .collection('EntranceExamResult')
            .add(enExam.toMap());
        return true;
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> addEntranceMajor(EntranceMajor enMajor) async {
    try {
      SharedPreferences preferences = await UIdata.getPrefs();
      Login login = Login.fromJson(jsonDecode(preferences.getString('login')));
      return Firestore.instance
          .collectionGroup('Alumni')
          .where('username', isEqualTo: login.username)
          .getDocuments()
          .then((alumniDoc) async {
        if (alumniDoc.documents[0] == null) return false;
        await alumniDoc.documents[0].reference
            .collection('EntranceMajor')
            .add(enMajor.toMap());
        return true;
      });
    } catch (error) {
      rethrow;
    }
  }
}
