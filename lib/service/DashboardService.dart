import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:student_guidance/model/Alumni.dart';
import 'package:student_guidance/model/DashboardAlumni.dart';

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
      int total = 0;
      int studying = 0;
      int working = 0;
      int other = 0;

      total = alumniData.documents.length;

      Set<String> listYear = alumniData.documents
          .map((alumniDoc) => Alumni.fromJson(alumniDoc.data).graduateYear)
          .toSet();
      List<DashboardAlumni> listDashboardAlumni = List();

      for (var year in listYear) {
        DashboardAlumni dashboardAlumni;
        for (var alumniDoc in alumniData.documents) {
          String graduateDateTime =
              Alumni.fromJson(alumniDoc.data).graduateYear;

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

        dashboardAlumni =
            DashboardAlumni(year, total, studying, working, other);
        listDashboardAlumni.add(dashboardAlumni);
      }

      return listDashboardAlumni.take(5).toList();
    });
  }
}
