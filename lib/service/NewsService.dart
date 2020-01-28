import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:student_guidance/model/News.dart';

class NewsService {
  Future getNews() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('News').getDocuments();
    return qn.documents;
  }

  Stream<List<News>> getAllNewsBySchoolName(String schoolName) {
    Query collectionReference = Firestore.instance
        .collectionGroup('News')
        .where('schoolName', isEqualTo: schoolName);

    return collectionReference.snapshots().map((snapshot) {
      return snapshot.documents.map((document) {
        return News.fromJson(document.data);
      }).toList();
    });
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
