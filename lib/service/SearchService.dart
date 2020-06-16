import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Career.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/utils/UIdata.dart';

class SearchService {
  Future<QuerySnapshot> getSearchItem(
    String collectionName,
    String orderByName,
    DocumentSnapshot lastDocument,
    int perPage,
  ) async {
    try {
      Query query = Firestore.instance
          .collectionGroup(collectionName)
          .orderBy(orderByName);
      query = query.limit(perPage);
      return lastDocument != null
          ? query.startAfterDocument(lastDocument).getDocuments()
          : query.getDocuments();
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot> getAllSearchItem(
    String collectionName,
    String orderByName,
  ) async {
    try {
      Query query = Firestore.instance
          .collectionGroup(collectionName)
          .orderBy(orderByName);
      return query.getDocuments();
    } catch (e) {
      rethrow;
    }
  }

  Future<int> countSearchItem(String collectionName, String orderByName,
      List<String> whereFields, List<String> whereValue) async {
    try {
      Set<String> setCount = Set();
      Query query = Firestore.instance
          .collectionGroup(collectionName)
          .orderBy(orderByName);
      QuerySnapshot queryDocument = await query.getDocuments();
      if (whereFields.isNotEmpty) {
        for (var i = 0; i < whereFields.length; i++) {
          for (var doc in queryDocument.documents) {
            String _fieldValue = doc.data[whereFields[i]].toString();
            if (_fieldValue.contains(whereValue[i])) {
              setCount.add(doc.data[orderByName].toString());
            }
          }
        }
      } else {
        setCount = queryDocument.documents
            .map((doc) => doc.data[orderByName].toString())
            .toSet();
      }
      return setCount.length;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getCountAlumniEntranceMajor(String university) async {
    SharedPreferences sharedPref = await UIdata.getPrefs();

    return await Firestore.instance
        .collectionGroup('Alumni')
        .where('schoolName', isEqualTo: sharedPref.getString('schoolId'))
        .getDocuments()
        .then((alumniDocs) async {
      int countAlumni = 0;
      for (var doc in alumniDocs.documents) {
        await doc.reference
            .collection('EntranceMajor')
            .where('universityName', isEqualTo: university)
            .getDocuments()
            .then((entranceDoc) {
          if (entranceDoc.documents.isNotEmpty) {
            countAlumni++;
          }
        });
      }
      return countAlumni;
    });
  }

  Future<List<University>> getListUniversity(String doc) async {
    // List<University> list =  List<University>();
    // try {
    //   CollectionReference collectionReferenceUniver =
    //       Firestore.instance.collection('Faculty');
    //   QuerySnapshot qs = await collectionReferenceUniver
    //       .where('faculty_name', isEqualTo: doc)
    //       .getDocuments();

    //   for (DocumentSnapshot ds in qs.documents) {
    //     Faculty f = Faculty.fromJson(ds.data);
    //     DocumentReference refQuery = f.university;

    //     University university =  University();
    //     university = await refQuery.get().then((docs) async {
    //       return University.fromJson(docs.data);
    //     });

    //     list.add(university);
    //   }
    //   return list;
    // } catch (e) {
    //   rethrow;
    // }
  }

  Future<List<University>> getListUniversitybyMajor(String doc) async {
    List<University> list = List<University>();
    try {
      CollectionReference collectionReferenceUniver =
          Firestore.instance.collection('Major');
      QuerySnapshot qs = await collectionReferenceUniver
          .where('major_name', isEqualTo: doc)
          .getDocuments();

      // for (DocumentSnapshot ds in qs.documents) {
      //   Major major = Major.fromJson(ds.data);
      //   DocumentReference refQuery = major.faculty;

      //   Faculty faculty =  Faculty();
      //   faculty = await refQuery.get().then((docs) async {
      //     return Faculty.fromJson(docs.data);
      //   });
      //   DocumentReference refQueryUniver = faculty.university;
      //   University university =  University();
      //   university = await refQueryUniver.get().then((docs) async {
      //     return University.fromJson(docs.data);
      //   });

      //   list.add(university);
      // }
      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Career>> getListCareer(List<dynamic> listCareer) async {
    List<DocumentReference> list = List<DocumentReference>();
    List<Career> listReturn = List<Career>();
    for (int i = 0; i < listCareer.length; i++) {
      list.add(listCareer[i]);
    }
    for (DocumentReference doc in list) {
      Career career = Career();
      career = await doc.get().then((docs) async {
        return Career.fromJson(docs.data);
      });
      listReturn.add(career);
    }
    return listReturn;
  }

  Future<Major> getMajorForSearch(String majorName, String univerName) async {
    try {
      List<Major> major = List<Major>();
      DocumentReference dof;
      CollectionReference collectionReferenceUniver =
          Firestore.instance.collection('University');
      QuerySnapshot qs = await collectionReferenceUniver
          .where('university_name', isEqualTo: univerName)
          .getDocuments();
      dof = qs.documents[0].reference;

      CollectionReference collectionReferenceFac =
          Firestore.instance.collection('Faculty');
      QuerySnapshot qsfac = await collectionReferenceFac
          .where('university', isEqualTo: dof)
          .getDocuments();
      for (DocumentSnapshot qs in qsfac.documents) {
        Faculty faculty = Faculty.fromJson(qs.data);
        List<DocumentReference> listDocMajor = List<DocumentReference>();
        // List<dynamic> listmajor = faculty.major;

        // for (int i = 0; i < listmajor.length; i++) {
        //   listDocMajor.add(listmajor[i]);
        // }

        for (DocumentReference doc in listDocMajor) {
          Major mj = Major();
          mj = await doc.get().then((docs) async {
            return Major.fromJson(docs.data);
          });
          major.add(mj);
        }
      }
      Major majorReturn = Major();
      for (Major ma in major) {
        if (ma.majorName == majorName) {
          majorReturn = ma;
        }
      }
      return majorReturn;
    } catch (e) {
      rethrow;
    }
  }

  Future<Faculty> getFacultyForSearch(String facName, String uname) async {
    try {
      DocumentReference dof;
      CollectionReference collectionReferenceUniver =
          Firestore.instance.collection('University');
      QuerySnapshot qs = await collectionReferenceUniver
          .where('university_name', isEqualTo: uname)
          .getDocuments();
      dof = qs.documents[0].reference;
      CollectionReference collectionReferenceFac =
          Firestore.instance.collection('Faculty');
      QuerySnapshot qsfac = await collectionReferenceFac
          .where('university', isEqualTo: dof)
          .where('faculty_name', isEqualTo: facName)
          .getDocuments();

      Faculty fac = Faculty.fromJson(qsfac.documents[0].data);

      return fac;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Major>> getListMajor(Faculty fac) async {
    List<Major> list = List<Major>();

    // for (DocumentReference f in fac.major) {
    //   Major m = await Firestore.instance
    //       .collection('Major')
    //       .document(f.documentID)
    //       .get()
    //       .then((major) {
    //     return Major.fromJson(major.data);
    //   });
    //   list.add(m);
    // }
    return list;
  }
}
