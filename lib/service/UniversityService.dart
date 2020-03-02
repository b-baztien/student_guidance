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

    //Map<UniversityName, Map<FacultyName, List<MajorName>>>
    // return universitySnapshot.map((uniSnapshot) {
    //   Map<String, Map<String, List<String>>> mapUniversity = Map();
    //   for (var uniDoc in uniSnapshot.documents) {
    //     uniDoc.reference.collection('Faculty').snapshots().map((facSnapshot) {
    //       Map<String, List<String>> mapFaculty = Map();
    //       for (var facDoc in facSnapshot.documents) {
    //         facDoc.reference
    //             .collection('Major')
    //             .snapshots()
    //             .map((majorSnapshot) {
    //           List<String> majorList = majorSnapshot.documents
    //               .map((majorDoc) => Major.fromJson(majorDoc.data).majorName)
    //               .toList();
    //           mapFaculty[Faculty.fromJson(facDoc.data).facultyName] = majorList;
    //         });
    //       }
    //       mapUniversity[University.fromJson(uniDoc.data).universityname] =
    //           mapFaculty;
    //     });
    //   }
    //   return mapUniversity;
    // });

    return Rx.combineLatest3(universitySnapshot, facultySnapshot, majorSnapshot,
        (QuerySnapshot uniData, QuerySnapshot facData,
            QuerySnapshot majorData) {
      //Map<UniversityName, Map<FacultyName, List<MajorName>>>
      Map<String, Map<String, List<String>>> mapUniversity = Map();

      for (var uniDoc in uniData.documents) {
        Map<String, List<String>> mapFaculty = Map();
        for (var facDoc in facData.documents) {
          List<String> listMajor = List();
          for (var majorDoc in majorData.documents) {
            if (facDoc.documentID ==
                majorDoc.reference.parent().parent().documentID) {
              // listMajor.add(Major.fromJson(majorDoc.data).majorName);
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
