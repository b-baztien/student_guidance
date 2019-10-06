import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:student_guidance/model/News.dart';

class NewsService {
  Future getNews() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('News').getDocuments();
    return qn.documents;
  }

  Future<List<News>> getNewsList() async {
    List<DocumentSnapshot> templist;
    List<News> list = new List();
    CollectionReference collectionReference =
        Firestore.instance.collection('News');
    QuerySnapshot collecttionSnapshot =
        await collectionReference.getDocuments();
    templist = collecttionSnapshot.documents;
    list = templist.map((DocumentSnapshot doc) {
      return News.fromJson(doc.data);
    }).toList();
    return list;
  }

 Future<String> getImage(String path) async{
   
   String url;
   try{
     StorageReference ref = FirebaseStorage.instance.ref().child(path);
    url = await ref.getDownloadURL().then((image) async{
        return await image.toString();
    });
   
    return url;
   }catch(e) {
      rethrow;
    }
   
 }
}
