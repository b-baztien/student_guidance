import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Faculty.dart';
class FacultyService{
  Future<Faculty> getFaculty(DocumentReference doc) async {
    try {
      DocumentReference refQuery = doc;
      Faculty faculty = await refQuery.get().then((doc) async {
        return Faculty.fromJson(doc.data);
      });
      return faculty;
    } catch (e) {
      rethrow;
    }
  }

  
   Future<List<Faculty>> getFacultyList(List<DocumentReference> templist ) async {
    List<Faculty> list = new List();
    for(var i =0;i<templist.length;i++){
      try{
         DocumentReference refQuery = templist[i];
          Faculty faculty = await refQuery.get().then((doc) async {
        return Faculty.fromJson(doc.data);
      });
      list.add(faculty);
      }catch(e){
        rethrow;
      }
    }
    return list;
   }
}