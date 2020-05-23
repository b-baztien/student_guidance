import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolService {
  Future<List<DocumentSnapshot>> getAllSchool() async {
    try {
      Query query =
          Firestore.instance.collectionGroup('School').orderBy('school_name');
      List<DocumentSnapshot> listSchool =
          await query.getDocuments().then((doc) async {
        return doc.documents;
      });
      return listSchool;
    } catch (e) {
      rethrow;
    }
  }
}
