import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:student_guidance/model/News.dart';

class NewsService {
  Future getNews() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('News').getDocuments();
    return qn.documents;
  }

  Future<List<News>> getAllNewsBySchoolName(String schoolName) async {
    List<DocumentChange> templist;
    List<News> list = new List();
    CollectionReference collectionReference = Firestore.instance
        .collection('School')
        .document(schoolName)
        .collection('Teacher');
    QuerySnapshot collecttionSnapshot = await collectionReference.getDocuments();
    templist = collecttionSnapshot.documentChanges;
    for(DocumentChange dc in templist){
      QuerySnapshot newsSnapshot = await dc.document.reference.collection('News').getDocuments();
      for(DocumentChange dcsnap in newsSnapshot.documentChanges){
        list.add(News.fromJson(dcsnap.document.data));
      }
    }
    print(list[0].startTime.toDate());
    return list;
  }


  Future<String> getImage(String path) async {
    String url;
    try {
      StorageReference ref = FirebaseStorage.instance.ref().child(path);
      url = await ref.getDownloadURL().then((image) async {
        return image.toString();
      });

      return url;
    } catch (e) {
      rethrow;
    }
  }
}
