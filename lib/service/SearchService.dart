import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:student_guidance/model/Career.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/FilterSeachItems.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/model/University.dart';

class SearchService {
  Stream<List<FilterSeachItems>> getAllSearchItem() {
    Stream<QuerySnapshot> universitySnapshot =
        Firestore.instance.collectionGroup('University').snapshots();
    Stream<QuerySnapshot> facultySnapshot =
        Firestore.instance.collectionGroup('Faculty').snapshots();
    Stream<QuerySnapshot> majorSnapshot =
        Firestore.instance.collectionGroup('Major').snapshots();
    Stream<QuerySnapshot> careerSnapshot =
        Firestore.instance.collectionGroup('Career').snapshots();

    return Rx.combineLatest4(
      universitySnapshot,
      facultySnapshot,
      majorSnapshot,
      careerSnapshot,
      (QuerySnapshot uniData, QuerySnapshot facData, QuerySnapshot majorData,
          QuerySnapshot careerData) {
        List<FilterSeachItems> listItem = new List<FilterSeachItems>();

        Set<String> uniNameSet = uniData.documents
            .map((doc) => University.fromJson(doc.data).universityname)
            .toSet();

        Set<String> facNameSet = facData.documents
            .map((doc) => Faculty.fromJson(doc.data).facultyName)
            .toSet();

        Set<String> majorNameSet = majorData.documents
            .map((doc) => Major.fromJson(doc.data).majorName)
            .toSet();

        Set<String> careerNameSet = careerData.documents
            .map((doc) => Career.fromJson(doc.data).careerName)
            .toSet();

        for (var uniName in uniNameSet) {
          FilterSeachItems filterSeachItems = new FilterSeachItems();
          filterSeachItems.name = uniName;
          filterSeachItems.type = 'University';
          listItem.add(filterSeachItems);
        }

        for (var facName in facNameSet) {
          FilterSeachItems filterSeachItems = new FilterSeachItems();
          filterSeachItems.name = facName;
          filterSeachItems.type = 'Faculty';
          listItem.add(filterSeachItems);
        }

        for (var majorName in majorNameSet) {
          FilterSeachItems filterSeachItems = new FilterSeachItems();
          filterSeachItems.name = majorName;
          filterSeachItems.type = 'Major';
          listItem.add(filterSeachItems);
        }

        for (var careerName in careerNameSet) {
          FilterSeachItems filterSeachItems = new FilterSeachItems();
          filterSeachItems.name = careerName;
          filterSeachItems.type = 'Career';
          listItem.add(filterSeachItems);
        }

        return listItem;
      },
    );
  }

  Future<List<FilterSeachItems>> getItemSearch() async {
    List<DocumentSnapshot> templistUni;
    List<DocumentSnapshot> templistFac;
    List<DocumentSnapshot> templistMajor;
    List<DocumentSnapshot> templistCareer;
    List<FilterSeachItems> listItem = new List<FilterSeachItems>();

    CollectionReference collectionReferenceUniver =
        Firestore.instance.collection('University');
    QuerySnapshot qsUniver = await collectionReferenceUniver.getDocuments();
    CollectionReference collectionReferenceFac =
        Firestore.instance.collection('Faculty');
    QuerySnapshot qsFac = await collectionReferenceFac.getDocuments();
    CollectionReference collectionReferenceMajor =
        Firestore.instance.collection('Major');
    QuerySnapshot qsMajor = await collectionReferenceMajor.getDocuments();
    CollectionReference collectionReferenceCareer =
        Firestore.instance.collection('Career');
    QuerySnapshot qsCareer = await collectionReferenceCareer.getDocuments();
    templistUni = qsUniver.documents;
    templistFac = qsFac.documents;
    templistMajor = qsMajor.documents;
    templistCareer = qsCareer.documents;
    for (DocumentSnapshot ds in templistUni) {
      University u = University.fromJson(ds.data);
      FilterSeachItems ff = new FilterSeachItems();
      ff.name = u.universityname;
      ff.type = 'University';
      ff.documentSnapshot = ds;
      listItem.add(ff);
    }
    Set<String> nameFac = new Set<String>();
    for (DocumentSnapshot ds in templistFac) {
      Faculty f = Faculty.fromJson(ds.data);
      nameFac.add(f.facultyName);
    }
    for (String ck in nameFac) {
      FilterSeachItems ff = new FilterSeachItems();
      ff.name = ck;
      ff.type = 'Faculty';
      listItem.add(ff);
    }
    Set<String> nameMajor = new Set<String>();
    for (DocumentSnapshot ds in templistMajor) {
      Major m = Major.fromJson(ds.data);
      nameMajor.add(m.majorName);
    }
    for (String ck in nameMajor) {
      FilterSeachItems ff = new FilterSeachItems();
      ff.name = ck;
      ff.type = 'Major';
      listItem.add(ff);
    }

    for (DocumentSnapshot ds in templistCareer) {
      Career c = Career.fromJson(ds.data);
      FilterSeachItems ff = new FilterSeachItems();
      ff.name = c.careerName;
      ff.type = 'Career';
      listItem.add(ff);
    }
    List<FilterSeachItems> listShow = new List<FilterSeachItems>();
    Set<FilterSeachItems> name = new Set<FilterSeachItems>();
    for (FilterSeachItems fs in listItem) {
      name.add(fs);
    }

    listShow = name.toList();

    return listShow;
  }

  Future<List<University>> getListUniversity(String doc) async {
    // List<University> list = new List<University>();
    // try {
    //   CollectionReference collectionReferenceUniver =
    //       Firestore.instance.collection('Faculty');
    //   QuerySnapshot qs = await collectionReferenceUniver
    //       .where('faculty_name', isEqualTo: doc)
    //       .getDocuments();

    //   for (DocumentSnapshot ds in qs.documents) {
    //     Faculty f = Faculty.fromJson(ds.data);
    //     DocumentReference refQuery = f.university;

    //     University university = new University();
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
    List<University> list = new List<University>();
    try {
      CollectionReference collectionReferenceUniver =
          Firestore.instance.collection('Major');
      QuerySnapshot qs = await collectionReferenceUniver
          .where('major_name', isEqualTo: doc)
          .getDocuments();

      // for (DocumentSnapshot ds in qs.documents) {
      //   Major major = Major.fromJson(ds.data);
      //   DocumentReference refQuery = major.faculty;

      //   Faculty faculty = new Faculty();
      //   faculty = await refQuery.get().then((docs) async {
      //     return Faculty.fromJson(docs.data);
      //   });
      //   DocumentReference refQueryUniver = faculty.university;
      //   University university = new University();
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
    List<DocumentReference> list = new List<DocumentReference>();
    List<Career> listReturn = new List<Career>();
    for (int i = 0; i < listCareer.length; i++) {
      list.add(listCareer[i]);
    }
    for (DocumentReference doc in list) {
      Career career = new Career();
      career = await doc.get().then((docs) async {
        return Career.fromJson(docs.data);
      });
      listReturn.add(career);
    }
    return listReturn;
  }

  Future<Major> getMajorForSearch(String majorName, String univerName) async {
    try {
      List<Major> major = new List<Major>();
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
        List<DocumentReference> listDocMajor = new List<DocumentReference>();
        // List<dynamic> listmajor = faculty.major;

        // for (int i = 0; i < listmajor.length; i++) {
        //   listDocMajor.add(listmajor[i]);
        // }

        for (DocumentReference doc in listDocMajor) {
          Major mj = new Major();
          mj = await doc.get().then((docs) async {
            return Major.fromJson(docs.data);
          });
          major.add(mj);
        }
      }
      Major majorReturn = new Major();
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
    List<Major> list = new List<Major>();

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
