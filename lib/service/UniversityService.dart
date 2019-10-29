import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/GetImageService.dart';

CollectionReference ref = Firestore.instance.collection("University");

class UniversityService {
  Future<List<University>> getUniversity() async {
    List<DocumentSnapshot> templist;
    List<University> list = new List();
    CollectionReference collectionReference =
        Firestore.instance.collection('University');

    QuerySnapshot collecttionSnapshot =
        await collectionReference.getDocuments();

    templist = collecttionSnapshot.documents;
    list = templist.map((DocumentSnapshot doc) {
      return University.fromJson(doc.data);
    }).toList();
    for (int i = 0; i < list.length; i++) {
      String sss =
          await GetImageService().getImage(list[i].image).then((url) async {
        return url;
      });
      list[i].image = sss;
    }
    
    return list;
  }

  updateView(DocumentSnapshot doc) async {
    doc.reference.updateData({'view': doc['view'] + 1});
  }
}
