import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Alumni.dart';
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

  Future<bool> addEntranceMajor(EntranceMajor enMajor, Alumni alumni) async {
    try {
      WriteBatch batch = Firestore.instance.batch();
      SharedPreferences preferences = await UIdata.getPrefs();
      Login login = Login.fromJson(jsonDecode(preferences.getString('login')));
      return Firestore.instance
          .collectionGroup('Alumni')
          .where('username', isEqualTo: login.username)
          .getDocuments()
          .then((alumniDoc) async {
        if (alumniDoc.documents.first == null) return false;

        batch.setData(alumniDoc.documents.first.reference, alumni.toMap());

        CollectionReference entranceCollection =
            alumniDoc.documents.first.reference.collection('EntranceMajor');

        QuerySnapshot entranceSnapshot =
            await entranceCollection.getDocuments();

        for (var doc in entranceSnapshot.documents) {
          batch.delete(doc.reference);
        }

        await batch.commit();

        await entranceCollection.add(enMajor.toMap());
        return true;
      });
    } catch (error) {
      rethrow;
    }
  }
}
