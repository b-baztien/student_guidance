import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/University.dart';

class FacultyService {
  Stream<List<DocumentSnapshot>> getListFacultyByUniversityId(
      String universityId) {
    DocumentReference universityDocument =
        Firestore.instance.collection('University').document(universityId);

    Stream<QuerySnapshot> facultySnapshot = Firestore.instance
        .document(universityDocument.path)
        .collection('Faculty')
        .snapshots();

    return facultySnapshot.map((facSnapshot) {
      if (facSnapshot.documents.length == 0) return null;
      return facSnapshot.documents.map((facDoc) => facDoc).toList();
    });
  }

  Future<DocumentSnapshot> getFacultyByFacNameAndUniRef(
      String facName, DocumentReference uniRef) async {
    try {
      Query query = Firestore.instance
          .document(uniRef.path)
          .collection('Faculty')
          .where('faculty_name', isEqualTo: facName);
      DocumentSnapshot faculty = await query.getDocuments().then((doc) async {
        return doc.documents.first;
      });
      return faculty;
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentSnapshot> getFacultyByUniNameAndMajorName(
      String uniName, String majorName) async {
    try {
      Query query = Firestore.instance
          .collectionGroup('University')
          .where('university_name', isEqualTo: uniName);
      DocumentReference faculty = await query.getDocuments().then((doc) async {
        Query majorQuery = Firestore.instance
            .collectionGroup('Major')
            .where('majorName', isEqualTo: majorName);
        return await majorQuery.getDocuments().then((majorDoc) {
          for (var majorSnap in majorDoc.documents) {
            String uniId = majorSnap.reference
                .parent()
                .parent()
                .parent()
                .parent()
                .documentID;
            if (doc.documents.first.documentID == uniId) {
              return majorSnap.reference.parent().parent();
            }
          }
          return null;
        });
      });
      return Firestore.instance.document(faculty.path).get();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<DocumentSnapshot>> getAllFaculty() {
    Stream<QuerySnapshot> facultySnapshot =
        Firestore.instance.collectionGroup('Faculty').snapshots();
    return facultySnapshot.map((facSnapShot) => facSnapShot.documents);
  }

  Future<List<Faculty>> getFacultyByUniversityId(String uniId) async {
    try {
      Query query = Firestore.instance
          .collection('University')
          .document(uniId)
          .collection('Faculty');
      List<Faculty> faculty = await query.getDocuments().then((doc) async {
        return doc.documents.map((docData) {
          return Faculty.fromJson(docData.data);
        }).toList();
      });
      return faculty;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Faculty>> getUniversity(List<DocumentSnapshot> templist) async {
    List<Faculty> list = new List();
    CollectionReference collectionReference =
        Firestore.instance.collection('University');
    QuerySnapshot collecttionSnapshot =
        await collectionReference.getDocuments();
    templist = collecttionSnapshot.documents;
    list = templist.map((DocumentSnapshot doc) {
      return Faculty.fromJson(doc.data);
    }).toList();
    return list;
  }
}
