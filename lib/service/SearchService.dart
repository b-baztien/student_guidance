import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Carrer.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/FilterSeachItems.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/model/University.dart';

class SearchService {
  Future<List<FilterSeachItems>> getItemSearch() async {
    List<DocumentSnapshot> templistUni;
     List<DocumentSnapshot> templistFac;
      List<DocumentSnapshot> templistMajor;
      List<DocumentSnapshot> templistCarrer;
      List<FilterSeachItems> listItem = new List<FilterSeachItems> ();
    CollectionReference collectionReferenceUniver = Firestore.instance.collection('University');
    QuerySnapshot qsUniver = await collectionReferenceUniver.getDocuments();
     CollectionReference collectionReferenceFac = Firestore.instance.collection('Faculty');
    QuerySnapshot qsFac = await collectionReferenceFac.getDocuments();
     CollectionReference collectionReferenceMajor = Firestore.instance.collection('Major');
    QuerySnapshot qsMajor = await collectionReferenceMajor.getDocuments();
      CollectionReference collectionReferenceCarrer = Firestore.instance.collection('Carrer');
    QuerySnapshot qsCarrer = await collectionReferenceCarrer.getDocuments();
    templistUni = qsUniver.documents;
    templistFac =qsFac.documents;
    templistMajor = qsMajor.documents;
  templistCarrer = qsCarrer.documents;
    for(DocumentSnapshot ds in templistUni){
      University u = University.fromJson(ds.data);
        FilterSeachItems ff = new FilterSeachItems();
        ff.id = ds.documentID;
        ff.name = u.universityname;
        ff.type = 'University';
        ff.documentSnapshot = ds;
        listItem.add(ff);
      }
      for(DocumentSnapshot ds in templistFac){
      Faculty f = Faculty.fromJson(ds.data);
        FilterSeachItems ff = new FilterSeachItems();
        ff.id = ds.documentID;
        ff.name = f.facultyName;
        ff.type = 'Faculty';
        ff.documentSnapshot = ds;
        listItem.add(ff);
      }
      for(DocumentSnapshot ds in templistMajor){
      Major m = Major.fromJson(ds.data);
        FilterSeachItems ff = new FilterSeachItems();
        ff.id = ds.documentID;
        ff.name = m.majorName;
        ff.type = 'Major';
        ff.documentSnapshot = ds;
        listItem.add(ff);
      }
      for(DocumentSnapshot ds in templistCarrer){
      Carrer c = Carrer.fromJson(ds.data);
        FilterSeachItems ff = new FilterSeachItems();
        ff.id = ds.documentID;
        ff.name = c.carrer_name;
        ff.type = 'Carrer';
        ff.documentSnapshot = ds;
        listItem.add(ff);
      }
      for(FilterSeachItems f in listItem){
        print(f.name);
      }
  
    return listItem;
  }
}
