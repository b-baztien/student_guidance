import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Faculty.dart';
class FacultyService{
  Future<Faculty> getFaculty(DocumentReference doc) async {
    try {
      DocumentReference refQuery = doc;
      Faculty faculty = await refQuery.get().then((doc) async {
        return Faculty.fromJson(doc.data);
      });
      return await faculty;
    } catch (e) {
      rethrow;
    }
  }

   Future<List<Faculty>> getUniversity( List<DocumentSnapshot> templist) async {
    List<Faculty> list = new List();
    CollectionReference collectionReference = Firestore.instance.collection('University');
    QuerySnapshot collecttionSnapshot = await collectionReference.getDocuments();
    templist = collecttionSnapshot.documents;
    list = templist.map((DocumentSnapshot doc){
      return Faculty.fromJson(doc.data);
    }).toList();
    return list;
   }
}