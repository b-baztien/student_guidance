import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Major.dart';

class MajorService {
  
   Future<List<Major>> getAllMajor() async {
    List<DocumentSnapshot> templist;
    List<Major> list = new List();
    CollectionReference collectionReference =
        Firestore.instance.collection('Major');
       
    QuerySnapshot collecttionSnapshot =
        await collectionReference.getDocuments();
         print(collecttionSnapshot);
    templist = collecttionSnapshot.documents;
    list = templist.map((DocumentSnapshot doc) {
      
      return Major.fromJson(doc.data);
    }).toList();
    return list;
  }
  
}