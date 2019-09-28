import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/News.dart';

class NewsService {
  Future getNews() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('News').getDocuments();
    return qn.documents;
  }


   Future<List<News>> getNewsList() async {
    List<DocumentSnapshot> templist;
    List<News> list = new List();
    CollectionReference collectionReference = Firestore.instance.collection('News');
    QuerySnapshot collecttionSnapshot = await collectionReference.getDocuments();
    templist = collecttionSnapshot.documents;
    list = templist.map((DocumentSnapshot doc){
      return News.fromJson(doc.data);
    }).toList();
    return list;
   }


}