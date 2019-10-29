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
        ff.name = u.universityname;
        ff.type = 'University';
        ff.documentSnapshot = ds;
        listItem.add(ff);
      }
      Set<String> nameFac = new Set<String>();
      for(DocumentSnapshot ds in templistFac){
      Faculty f = Faculty.fromJson(ds.data); 
        nameFac.add(f.facultyName);
      }
      for(String ck in nameFac){
         FilterSeachItems ff = new FilterSeachItems();
        ff.name = ck;
        ff.type = 'Faculty';
        listItem.add(ff);
      }
      Set<String> nameMajor = new Set<String>();
      for(DocumentSnapshot ds in templistMajor){
      Major m = Major.fromJson(ds.data);
      nameMajor.add(m.majorName);
     
      }
      for(String ck in nameMajor){
           FilterSeachItems ff = new FilterSeachItems();
        ff.name = ck;
        ff.type = 'Major';
        listItem.add(ff);
      }

      for(DocumentSnapshot ds in templistCarrer){
      Carrer c = Carrer.fromJson(ds.data);
        FilterSeachItems ff = new FilterSeachItems();
        ff.name = c.carrer_name;
        ff.type = 'Carrer';
        listItem.add(ff);
      }
      List<FilterSeachItems> listShow = new List<FilterSeachItems>();
      Set<FilterSeachItems> name = new Set<FilterSeachItems>();
     for(FilterSeachItems fs in listItem){
       name.add(fs);
     }

      listShow = name.toList();
 
  
    return listShow;
  }
  Future<List<University>> getListUniversity(String doc) async {
     List<University> list = new List<University>();
    try {
     
      CollectionReference collectionReferenceUniver = Firestore.instance.collection('Faculty');
      QuerySnapshot qs = await collectionReferenceUniver.where('faculty_name', isEqualTo: doc).getDocuments();
    
     for(DocumentSnapshot ds in qs.documents){
       Faculty f = Faculty.fromJson(ds.data); 
       DocumentReference refQuery = f.university;
      
         University university = new University();
     university = await refQuery.get().then((docs) async {
        return University.fromJson(docs.data);
     });
     
     list.add(university);
    
     }
      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Major>> getListMajor(String facName,String uname) async{
  
    List<Major> list = new List<Major>();
  List<DocumentReference> listTemp = new List<DocumentReference>();
    try{
        DocumentReference dof ;
          CollectionReference collectionReferenceUniver = Firestore.instance.collection('University');
         QuerySnapshot qs = await collectionReferenceUniver.where('university_name', isEqualTo: uname).getDocuments();
           dof = qs.documents[0].reference;
              CollectionReference collectionReferenceFac = Firestore.instance.collection('Faculty');
         QuerySnapshot qsfac = await collectionReferenceFac.where('university', isEqualTo: dof).where('faculty_name', isEqualTo: facName).getDocuments();
       
      Faculty fac = Faculty.fromJson(qsfac.documents[0].data);
     for(DocumentReference f in fac.major){
Major m = await Firestore.instance.collection('Major').document(f.documentID).get().then((major){
  return Major.fromJson(major.data);
});
list.add(m);
     }
      
        return list;
    }catch(e){
      rethrow;
    }
  }


}
