import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Major.dart';

class MajorService {
  Stream<List<DocumentSnapshot>> getAllMajor() {
    Stream<QuerySnapshot> majorSnapshot =
        Firestore.instance.collectionGroup('Major').snapshots();
    return majorSnapshot.map((mjSnapShot) => mjSnapShot.documents);
  }

  Future<List<String>> getAllMajorName() async {
    Query majorSnapshot = Firestore.instance.collectionGroup('Major');
    return await majorSnapshot.getDocuments().then((snapshot) => snapshot
        .documents
        .map((doc) => Major.fromJson(doc.data).majorName)
        .toSet()
        .toList());
  }

  Stream<List<DocumentSnapshot>> getMajorByFacultyReference(
      DocumentReference facDoc) {
    Stream<QuerySnapshot> majorSnapshot = Firestore.instance
        .document(facDoc.path)
        .collection('Major')
        .snapshots();

    return majorSnapshot.map((mjSnapShot) => mjSnapShot.documents);
  }

  Future<DocumentSnapshot> getMajorByMajorNameAndFacultyRef(
      String majorName, DocumentReference facRef) async {
    try {
      Query query = Firestore.instance
          .document(facRef.path)
          .collection('Major')
          .where('majorName', isEqualTo: majorName);
      DocumentSnapshot major = await query.getDocuments().then((doc) async {
        return doc.documents.first;
      });
      return major;
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentSnapshot> getMajor(
      String uniName, String facName, String majorName) async {
    try {
      Query query = Firestore.instance
          .collection('University')
          .where('university_name', isEqualTo: uniName);
      return await query.getDocuments().then((uniDoc) async {
        return await Firestore.instance
            .document(uniDoc.documents.first.reference.path)
            .collection('Faculty')
            .where('faculty_name', isEqualTo: facName)
            .getDocuments()
            .then((facDoc) async => (await Firestore.instance
                .document(facDoc.documents.first.reference.path)
                .collection('Major')
                .where('majorName', isEqualTo: majorName)
                .getDocuments()).documents.first);
      });
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
