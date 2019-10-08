import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/EntranceExamResult.dart';

class EntranService {
  Future<List<EntranceExamResult>> getAllEntranceExamResult() async {
    List<DocumentSnapshot> templist;
    List<EntranceExamResult> list = new List();
    CollectionReference collectionReference =
        Firestore.instance.collection('EntranceExamResult');
       
    QuerySnapshot collecttionSnapshot =
        await collectionReference.getDocuments();
         print(collecttionSnapshot);
    templist = collecttionSnapshot.documents;
    list = templist.map((DocumentSnapshot doc) {
      return EntranceExamResult.fromJson(doc.data);
    }).toList();
    return list;
  }
  
}