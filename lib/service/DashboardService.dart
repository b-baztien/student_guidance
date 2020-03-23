import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:student_guidance/model/Alumni.dart';
import 'package:student_guidance/model/DashboardAlumni.dart';

class DashboardService {
  Stream<DashboardAlumni> getAlumniDashboard(String schoolName, String year) {
    Stream<QuerySnapshot> alumniSnapshot = Firestore.instance
        .collectionGroup('Alumni')
        .where('schoolName', isEqualTo: schoolName)
        .where('graduate_year', isEqualTo: year)
        .snapshots();
    Stream<QuerySnapshot> entranceMajorSnapshot =
        Firestore.instance.collectionGroup('EntranceMajor').snapshots();

    return Rx.combineLatest2(alumniSnapshot, entranceMajorSnapshot,
        (QuerySnapshot alumniData, QuerySnapshot entranceMajorData) {
      int total = 0;
      int studying = 0;
      int working = 0;
      int other = 0;

      total = alumniData.documents.length;

      String year = Alumni.fromJson(alumniData.documents[0].data).graduateYear;

      DashboardAlumni dashboardAlumni;
      for (var alumniDoc in alumniData.documents) {
        String graduateDateTime = Alumni.fromJson(alumniDoc.data).graduateYear;

        if (year == graduateDateTime) {
          if (Alumni.fromJson(alumniDoc.data).status == 'ศึกษาต่อ') {
            studying++;
          } else if (Alumni.fromJson(alumniDoc.data).status == 'ไม่ระบุ') {
            other++;
          } else {
            working++;
          }
        }
      }
      dashboardAlumni = DashboardAlumni(year, total, studying, working, other);
      return dashboardAlumni;
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
}
