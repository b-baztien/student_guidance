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
    QuerySnapshot alumniSnapshot = await Firestore.instance
        .collectionGroup('Alumni')
        .where('schoolName', isEqualTo: schoolName)
        .where('graduate_year', isEqualTo: year)
        .where('status', isEqualTo: 'ศึกษาต่อ')
        .getDocuments();

    List<String> listUniName = new List();
    Map sortedMap;
    Map<String, int> mapUniName = Map();
    for (var alumniDoc in alumniSnapshot.documents) {
      QuerySnapshot entranceMajorSnapshot = await Firestore.instance
          .document(alumniDoc.reference.path)
          .collection('EntranceMajor')
          .getDocuments();

      listUniName = entranceMajorSnapshot.documents
          .map((doc) => EntranceMajor.fromJson(doc.data).universityName)
          .toList();
      for (var uniName in listUniName) {
        if (mapUniName.containsKey(uniName)) {
          mapUniName[uniName] = mapUniName[uniName] + 1;
        } else {
          mapUniName[uniName] = 1;
        }
      }

      List<String> sortedKeys = mapUniName.keys.toList(growable: false)
        ..sort((k1, k2) => mapUniName[k2].compareTo(mapUniName[k1]));

      sortedMap = Map.fromIterable(sortedKeys,
          key: (k) => k, value: (k) => mapUniName[k]);

      if (sortedKeys.length > 5) {
        print(sortedKeys);
        int _countOther = 0;
        sortedKeys.skip(5).forEach((key) {
          _countOther += sortedMap[key];
          sortedMap.remove(key);
        });
        sortedMap['อื่นๆ'] = _countOther;
      }
    }

    return mapUniName.isEmpty
        ? null
        : sortedMap
            .map((key, value) => MapEntry<String, int>('$key $value คน', value))
            .keys
            .toList();
  }

  Future<List<String>> getDashboardFaculty(
      String schoolName, String year) async {
    QuerySnapshot alumniSnapshot = await Firestore.instance
        .collectionGroup('Alumni')
        .where('schoolName', isEqualTo: schoolName)
        .where('graduate_year', isEqualTo: year)
        .where('status', isEqualTo: 'ศึกษาต่อ')
        .getDocuments();

    List<String> listFacName = new List();
    Map sortedMap;
    Map<String, int> mapFacName = Map();
    for (var alumniDoc in alumniSnapshot.documents) {
      QuerySnapshot entranceMajorSnapshot = await Firestore.instance
          .document(alumniDoc.reference.path)
          .collection('EntranceMajor')
          .getDocuments();

      listFacName = entranceMajorSnapshot.documents
          .map((doc) => EntranceMajor.fromJson(doc.data).facultyName)
          .toList();
      for (var facName in listFacName) {
        if (mapFacName.containsKey(facName)) {
          mapFacName[facName] = mapFacName[facName] + 1;
        } else {
          mapFacName[facName] = 1;
        }
      }

      List<String> sortedKeys = mapFacName.keys.toList(growable: false)
        ..sort((k1, k2) => mapFacName[k2].compareTo(mapFacName[k1]));

      sortedMap = Map.fromIterable(sortedKeys,
          key: (k) => k, value: (k) => mapFacName[k]);

      if (sortedKeys.length > 5) {
        print(sortedKeys);
        int _countOther = 0;
        sortedKeys.skip(5).forEach((key) {
          _countOther += sortedMap[key];
          sortedMap.remove(key);
        });
        sortedMap['อื่นๆ'] = _countOther;
      }
    }

    return mapFacName.isEmpty
        ? null
        : sortedMap
            .map((key, value) => MapEntry<String, int>('$key $value คน', value))
            .keys
            .toList();
  }

  Future<List<String>> getDashboardMajor(String schoolName, String year) async {
    QuerySnapshot alumniSnapshot = await Firestore.instance
        .collectionGroup('Alumni')
        .where('schoolName', isEqualTo: schoolName)
        .where('graduate_year', isEqualTo: year)
        .where('status', isEqualTo: 'ศึกษาต่อ')
        .getDocuments();

    List<String> listMajorName = new List();
    Map sortedMap;
    Map<String, int> mapMajorName = Map();
    for (var alumniDoc in alumniSnapshot.documents) {
      QuerySnapshot entranceMajorSnapshot = await Firestore.instance
          .document(alumniDoc.reference.path)
          .collection('EntranceMajor')
          .getDocuments();

      listMajorName = entranceMajorSnapshot.documents
          .map((doc) => EntranceMajor.fromJson(doc.data).majorName)
          .toList();
      for (var majorName in listMajorName) {
        if (mapMajorName.containsKey(majorName)) {
          mapMajorName[majorName] = mapMajorName[majorName] + 1;
        } else {
          mapMajorName[majorName] = 1;
        }
      }

      List<String> sortedKeys = mapMajorName.keys.toList(growable: false)
        ..sort((k1, k2) => mapMajorName[k2].compareTo(mapMajorName[k1]));

      sortedMap = Map.fromIterable(sortedKeys,
          key: (k) => k, value: (k) => mapMajorName[k]);

      if (sortedKeys.length > 5) {
        print(sortedKeys);
        int _countOther = 0;
        sortedKeys.skip(5).forEach((key) {
          _countOther += sortedMap[key];
          sortedMap.remove(key);
        });
        sortedMap['อื่นๆ'] = _countOther;
      }
    }

    return mapMajorName.isEmpty
        ? null
        : sortedMap
            .map((key, value) => MapEntry<String, int>('$key $value คน', value))
            .keys
            .toList();
  }
}
