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
        
    templist = collecttionSnapshot.documents;
    list = templist.map((DocumentSnapshot doc) {
      
      return Major.fromJson(doc.data);
    }).toList();
    return list;
  }
   Future<List<Major>> getListMajor(List<dynamic> major) async{
     List<DocumentReference> list = new List<DocumentReference>();
     for(int i=0;i<major.length;i++){
       list.add(major[i]);
     }
     List<Major> listmajor = new List<Major>();
     for(DocumentReference df in list){
       DocumentReference refQuery = df;
      Major mj = await refQuery.get().then((major) async{
        return Major.fromJson(major.data);
      });
      listmajor.add(mj);
     }
  return listmajor;
   }
  
}