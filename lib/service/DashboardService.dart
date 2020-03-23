import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:student_guidance/model/Alumni.dart';
import 'package:student_guidance/model/DashboardAlumni.dart';
import 'package:student_guidance/model/EntranceMajor.dart';

class DashboardService {
  Stream<List<DashboardAlumni>> getAlumniDashboard(String schoolName) {
    Stream<QuerySnapshot> alumniSnapshot = Firestore.instance
        .collectionGroup('Alumni')
        .where('schoolName', isEqualTo: schoolName)
        .orderBy('graduate_year')
        .snapshots();
    Stream<QuerySnapshot> entranceMajorSnapshot =
        Firestore.instance.collectionGroup('EntranceMajor').snapshots();

    return Rx.combineLatest2(alumniSnapshot, entranceMajorSnapshot,
        (QuerySnapshot alumniData, QuerySnapshot entranceMajorData) {
      Set<String> listYear = alumniData.documents
          .map((alumniDoc) => Alumni.fromJson(alumniDoc.data).graduateYear)
          .toSet();
      List<DashboardAlumni> listDashboardAlumni = List();

      for (var year in listYear) {
        int total = 0;
        int studying = 0;
        int working = 0;
        int other = 0;

        DashboardAlumni dashboardAlumni;
        for (var alumniDoc in alumniData.documents) {
          String graduateDateTime =
              Alumni.fromJson(alumniDoc.data).graduateYear;
          if (year == graduateDateTime) {
            total++;
            if (Alumni.fromJson(alumniDoc.data).status == 'ศึกษาต่อ') {
              studying++;
            } else if (Alumni.fromJson(alumniDoc.data).status == 'ไม่ระบุ') {
              other++;
            } else {
              working++;
            }
          }
        }

        dashboardAlumni =
            DashboardAlumni(year, total, studying, working, other);
        listDashboardAlumni.add(dashboardAlumni);
      }

      return listDashboardAlumni.take(5).toList();
    });
  }

  Future<List<String>> getDashboardYear(String schoolName) async {
    Query alumniSnapshot = Firestore.instance
        .collectionGroup('Alumni')
        .where('schoolName', isEqualTo: schoolName)
        .orderBy('graduate_year');

    return await alumniSnapshot.getDocuments().then((snapshot) {
      return snapshot.documents
          .map((doc) => Alumni.fromJson(doc.data).graduateYear)
          .toSet()
          .take(5)
          .toList();
    });
  }

  Future<List<String>> getDashboardUniversity(
      String schoolName, String year) async {
    Query alumniSnapshot = Firestore.instance
        .collectionGroup('Alumni')
        .where('schoolName', isEqualTo: schoolName)
        .where('graduate_year', isEqualTo: year)
        .where('status', isEqualTo: 'ศึกษาต่อ');

    return await alumniSnapshot.getDocuments().then((snapshot) async {
      return await Firestore.instance
          .document(snapshot.documents[0].reference.path)
          .collection('EntranceMajor')
          .getDocuments()
          .then((emSnap) {
        List<String> listUniName = emSnap.documents
            .map((doc) => EntranceMajor.fromJson(doc.data).universityName)
            .toList();
        Map<String, int> mapUniName = Map();
        for (var uniName in listUniName) {
          if (mapUniName.containsKey(uniName)) {
            mapUniName[uniName] = mapUniName[uniName] + 1;
          } else {
            mapUniName[uniName] = 1;
          }
          if (mapUniName.length == 5) {
            break;
          }
        }

        return mapUniName.keys.toList(growable: false)
          ..sort((k1, k2) => mapUniName[k1].compareTo(mapUniName[k2]));
      });
    });
  }

  Future<List<String>> getDashboardFaculty(
      String schoolName, String year) async {
    Query alumniSnapshot = Firestore.instance
        .collectionGroup('Alumni')
        .where('schoolName', isEqualTo: schoolName)
        .where('graduate_year', isEqualTo: year)
        .where('status', isEqualTo: 'ศึกษาต่อ');

    return await alumniSnapshot.getDocuments().then((snapshot) async {
      return await Firestore.instance
          .document(snapshot.documents[0].reference.path)
          .collection('EntranceMajor')
          .getDocuments()
          .then((emSnap) {
        List<String> listFacName = emSnap.documents
            .map((doc) => EntranceMajor.fromJson(doc.data).facultyName)
            .toList();
        Map<String, int> mapFacName = Map();
        for (var facName in listFacName) {
          if (mapFacName.containsKey(facName)) {
            mapFacName[facName] = mapFacName[facName] + 1;
          } else {
            mapFacName[facName] = 1;
          }
          if (mapFacName.length == 5) {
            break;
          }
        }

        return mapFacName.keys.toList(growable: false)
          ..sort((k1, k2) => mapFacName[k1].compareTo(mapFacName[k2]));
      });
    });
  }

  Future<List<String>> getDashboardMajor(String schoolName, String year) async {
    Query alumniSnapshot = Firestore.instance
        .collectionGroup('Alumni')
        .where('schoolName', isEqualTo: schoolName)
        .where('graduate_year', isEqualTo: year)
        .where('status', isEqualTo: 'ศึกษาต่อ');

    return await alumniSnapshot.getDocuments().then((snapshot) async {
      return await Firestore.instance
          .document(snapshot.documents[0].reference.path)
          .collection('EntranceMajor')
          .getDocuments()
          .then((emSnap) {
        List<String> listMajorName = emSnap.documents
            .map((doc) => EntranceMajor.fromJson(doc.data).majorName)
            .toList();
        Map<String, int> mapMajorName = Map();
        for (var majorName in listMajorName) {
          if (mapMajorName.containsKey(majorName)) {
            mapMajorName[majorName] = mapMajorName[majorName] + 1;
          } else {
            mapMajorName[majorName] = 1;
          }
          if (mapMajorName.length == 5) {
            break;
          }
        }

        return mapMajorName.keys.toList(growable: false)
          ..sort((k1, k2) => mapMajorName[k1].compareTo(mapMajorName[k2]));
      });
    });
  }
}
