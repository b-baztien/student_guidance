import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Major.dart';

class MajorService {
  Stream<List<DocumentSnapshot>> getAllMajor() {
    Stream<QuerySnapshot> majorSnapshot =
        Firestore.instance.collectionGroup('Major').snapshots();
    return majorSnapshot.map((mjSnapShot) => mjSnapShot.documents);
  }

  Stream<List<DocumentSnapshot>> getMajorByFacultyReference(
      DocumentReference facDoc) {
    Stream<QuerySnapshot> majorSnapshot = Firestore.instance
        .document(facDoc.path)
        .collection('Major')
        .snapshots();

    return majorSnapshot.map((mjSnapShot) => mjSnapShot.documents);
  }

  Future<DocumentSnapshot> getMajorByMajorNameAndUniRef(
      String majorName, DocumentReference facRef) async {
    try {
      Query query = Firestore.instance
          .document(facRef.path)
          .collection('Major')
          .where('majorName', isEqualTo: majorName);
      DocumentSnapshot major = await query.getDocuments().then((doc) async {
        return doc.documents.first;
      });
      print(major.data);
      return major;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<String>> getListMajorNameByCareerName(String careerName) {
    Stream<QuerySnapshot> majorSnapshot = Firestore.instance
        .collectionGroup('Major')
        .where('listCareerName', arrayContains: careerName)
        .orderBy('majorName')
        .snapshots();
    return majorSnapshot.map((mjSnapShot) => mjSnapShot.documents
        .map((doc) => Major.fromJson(doc.data).majorName)
        .toSet()
        .toList());
  }
}
