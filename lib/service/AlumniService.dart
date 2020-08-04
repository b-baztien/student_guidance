import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Alumni.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/utils/UIdata.dart';

class AlumniService {
  Future<Alumni> getCurrentAlumni() async {
    try {
      SharedPreferences preferences = await UIdata.getPrefs();
      Login login = Login.fromJson(jsonDecode(preferences.getString('login')));
      Query query = Firestore.instance
          .collectionGroup('Alumni')
          .where('username', isEqualTo: login.username);
      Alumni alumni = await query.getDocuments().then((doc) async {
        return doc.documents.isEmpty
            ? Alumni()
            : Alumni.fromJson(doc.documents[0].data);
      });
      return alumni;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateAlumni(Alumni alumni) async {
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

        return true;
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> addEditStudentRecommend(Alumni alumni) async {
    bool result = true;
    try {
      SharedPreferences preferences = await UIdata.getPrefs();
      Login login = Login.fromJson(jsonDecode(preferences.getString('login')));
      Firestore.instance
          .collectionGroup('Alumni')
          .where('username', isEqualTo: login.username)
          .getDocuments()
          .then((alumniDoc) async {
        alumniDoc.documents.isNotEmpty
            ? alumniDoc.documents[0].reference.updateData(alumni.toMap())
            : await alumniDoc.documents[0].reference
                .parent()
                .parent()
                .collection('StudentRecommend')
                .add(alumni.toMap());
      });
    } catch (e) {
      result = false;
      rethrow;
    }
    return result;
  }
}
