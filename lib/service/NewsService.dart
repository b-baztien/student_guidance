import 'package:cloud_firestore/cloud_firestore.dart';

class NewsService {
  Future getNews() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('News').getDocuments();
    return qn.documents;
  }
}