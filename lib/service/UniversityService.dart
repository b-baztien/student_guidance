import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/GetImageService.dart';

CollectionReference ref = Firestore.instance.collection("University");

class UniversityService {
  Stream<Map> getAllUniversityFacultyMajor() {
    Stream<QuerySnapshot> universitySnapshot =
        Firestore.instance.collectionGroup('University').snapshots();
    Stream<QuerySnapshot> facultySnapshot =
        Firestore.instance.collectionGroup('Faculty').snapshots();
    Stream<QuerySnapshot> majorSnapshot =
        Firestore.instance.collectionGroup('Major').snapshots();

    return Rx.combineLatest3(universitySnapshot, facultySnapshot, majorSnapshot,
        (QuerySnapshot uniData, QuerySnapshot facData,
            QuerySnapshot majorData) {
      Map<String, Map<String, List<String>>> mapUniversity = Map();

      for (var uniDoc in uniData.documents) {
        Map<String, List<String>> mapFaculty = Map();
        for (var facDoc in facData.documents) {
          List<String> listMajor = List();
          for (var majorDoc in majorData.documents) {
            if (facDoc.documentID ==
                majorDoc.reference.parent().parent().documentID) {
              listMajor.add(Major.fromJson(majorDoc.data).majorName);
              break;
            }
          }
          if (listMajor.isNotEmpty) {
            mapFaculty[Faculty.fromJson(facDoc.data).facultyName] = listMajor;
          }

          if (uniDoc.documentID ==
              facDoc.reference.parent().parent().documentID) {
            mapUniversity[University.fromJson(uniDoc.data).universityname] =
                mapFaculty;
            mapFaculty = Map();
          }
        }
      }
      return mapUniversity;
    });
  }

  Stream<List<DocumentSnapshot>> getAllUniversity() {
    Stream<QuerySnapshot> universitySnapshot =
        Firestore.instance.collectionGroup('University').snapshots();
    return universitySnapshot.map((uniSnapShot) => uniSnapShot.documents);
  }

  Stream<List<DocumentSnapshot>> getAllUniversityByMajor() {
    Stream<QuerySnapshot> universitySnapshot =
        Firestore.instance.collectionGroup('University').snapshots();
    Stream<QuerySnapshot> majorSnapshot =
        Firestore.instance.collectionGroup('Major').snapshots();

    return Rx.combineLatest2(universitySnapshot, majorSnapshot,
        (QuerySnapshot universityData, QuerySnapshot majorData) {
      Set<String> setUniversityId = new Set();
      List<DocumentSnapshot> listUniversityDoc = new List();

      for (var item in majorData.documents) {
        setUniversityId
            .add(item.reference.parent().parent().parent().parent().documentID);
      }

      for (var doc in universityData.documents) {
        if (setUniversityId.contains(doc.documentID)) {
          listUniversityDoc.add(doc);
        }
      }

      return listUniversityDoc;
    });
  }

  Future<List<DocumentSnapshot>> getListUniversityByProvince(
      String province) async {
    Future<QuerySnapshot> facultySnapshot = Firestore.instance
        .collectionGroup('University')
        .where('province', isEqualTo: province)
        .getDocuments();
    Set<DocumentSnapshot> listUniDoc = new Set();
    await facultySnapshot.then((uniDoc) async {
      listUniDoc = uniDoc.documents.map((docSnap) => docSnap);
    });
    return listUniDoc.toList();
  }

  Future<List<DocumentSnapshot>> getListUniversityByFacultyName(
      String facultyName) async {
    Future<QuerySnapshot> facultySnapshot = Firestore.instance
        .collectionGroup('Faculty')
        .where('faculty_name', isEqualTo: facultyName)
        .getDocuments();
    Set<DocumentSnapshot> listUniDoc = new Set();
    await facultySnapshot.then((facDoc) async {
      for (var item in facDoc.documents) {
        await item.reference.parent().parent().get().then((onValue) {
          listUniDoc.add(onValue);
        });
      }
    });
    return listUniDoc.toList();
  }

  Future<List<DocumentSnapshot>> getListUniversityByMajorName(
      String majorName) async {
    Future<QuerySnapshot> majorSnapshot = Firestore.instance
        .collectionGroup('Major')
        .where('majorName', isEqualTo: majorName)
        .getDocuments();
    Set<DocumentSnapshot> listUniDoc = new Set();
    await majorSnapshot.then((facDoc) async {
      for (var item in facDoc.documents) {
        await item.reference
            .parent()
            .parent()
            .parent()
            .parent()
            .get()
            .then((onValue) {
          listUniDoc.add(onValue);
        });
      }
    });
    return listUniDoc.toList();
  }

  Future<List<University>> getUniversity() async {
    List<DocumentSnapshot> templist;
    List<University> list = List();
    CollectionReference collectionReference =
        Firestore.instance.collection('University');

    QuerySnapshot collecttionSnapshot =
        await collectionReference.getDocuments();

    templist = collecttionSnapshot.documents;
    list = templist.map((DocumentSnapshot doc) {
      return University.fromJson(doc.data);
    }).toList();
    for (int i = 0; i < list.length; i++) {
      String sss =
          await GetImageService().getImage(list[i].image).then((url) async {
        return url;
      });
      list[i].image = sss;
    }

    return list;
  }

  updateView(DocumentSnapshot doc) async {
    doc.reference.updateData({'view': doc['view'] + 1});
  }
}
