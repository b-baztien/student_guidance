import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:async/async.dart';
CollectionReference ref = Firestore.instance.collection("University");

class UniversityService {
  Future<List<University>> getUniversity() async {
    List<DocumentSnapshot> templist;
    List<University> list = new List();
    CollectionReference collectionReference =
        Firestore.instance.collection('University');
       
    QuerySnapshot collecttionSnapshot =
        await collectionReference.getDocuments();
         print(collecttionSnapshot);
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

  updateView(String name, int view) async {
    
    await Firestore.instance.collection('University').document(name).updateData({'view': view + 1});

  }
  Future<Stream> test() async {
    Stream s1 =  Firestore.instance.collection('University').snapshots();
     Stream s2 =  Firestore.instance.collection('Faculty').snapshots();
    StreamZip bothStreams = StreamZip([s1, s2]).asBroadcastStream();
    return bothStreams;
  }
}
