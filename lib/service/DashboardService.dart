import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:student_guidance/model/Alumni.dart';
import 'package:student_guidance/model/DashboardAlumni.dart';

class DashboardService {
  Stream<DashboardAlumni> getAlumniDashboard(String schoolName) {
    Stream<QuerySnapshot> alumniSnapshot = Firestore.instance
        .collectionGroup('Alumni')
        .where('schoolName', isEqualTo: schoolName)
        .snapshots();
    Stream<QuerySnapshot> entranceMajorSnapshot =
        Firestore.instance.collectionGroup('EntranceMajor').snapshots();

    return Rx.combineLatest2(alumniSnapshot, entranceMajorSnapshot,
        (QuerySnapshot alumniData, QuerySnapshot entranceMajorData) {
      DashboardAlumni dashboardAlumni;
      int total = 0;
      int studying = 0;
      int working = 0;
      int other = 0;

      total = alumniData.documents.length;

      String latedGraduateDateTime = (DateTime.now().year + 542).toString();

      for (var alumniDoc in alumniData.documents) {
        String graduateDateTime = Alumni.fromJson(alumniDoc.data).graduateYear;

        print(graduateDateTime);
        if (latedGraduateDateTime == graduateDateTime) {
          if (Alumni.fromJson(alumniDoc.data).status == 'ศึกษาต่อ') {
            studying++;
          } else if (Alumni.fromJson(alumniDoc.data).status == 'ไม่ระบุ') {
            other++;
          } else {
            working++;
          }
        }
      }

      dashboardAlumni = DashboardAlumni(
          latedGraduateDateTime, total, studying, working, other);
      return dashboardAlumni;
    });
  }
}
