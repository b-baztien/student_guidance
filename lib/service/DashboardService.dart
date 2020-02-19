import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardService {
  Stream<Map> getStudentDashboard() {
    Firestore.instance
        .collectionGroup('EntranceExamRestult')
        .snapshots()
        .map((convert) {});
  }
}