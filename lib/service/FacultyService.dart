import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Faculty.dart';
class FacultyService{
  getAllFaculty(String uname) {
     List<Faculty> list = new List<Faculty>();
     var firestore = Firestore.instance;
    firestore.collection('University').document(uname).collection('Faculty').getDocuments().then((QuerySnapshot docs){
        if(docs.documents.isNotEmpty){
            for(int i=0;i<docs.documents.length;i++){
          Faculty _faculty = new Faculty();
         _faculty.facultyName = docs.documents[i].data['faculty_name'];
            _faculty.url = docs.documents[i].data['url'];
            list.add(_faculty);
          }
        }
    });
    return list;
  }
}