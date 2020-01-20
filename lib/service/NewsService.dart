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
    QuerySnapshot collecttionSnapshot =
        await collectionReference.getDocuments();
    templist = collecttionSnapshot.documentChanges;
    templist.forEach((DocumentChange doc) async {
      QuerySnapshot newsSnapshot =
          await doc.document.reference.collection('News').getDocuments();
      list = newsSnapshot.documentChanges.map((DocumentChange newsDoc) {
        print(newsDoc.document.data);
        return News.fromJson(newsDoc.document.data);
      }).toList();
    });
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
