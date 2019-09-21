import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:student_guidance/model/University.dart';
CollectionReference ref = Firestore.instance.collection("University");
class UniversityService{

  

   Future<List<University>> getUniversity() async {
    List<DocumentSnapshot> templist;
    List<University> list = new List();
    CollectionReference collectionReference = Firestore.instance.collection('University');
    QuerySnapshot collecttionSnapshot = await collectionReference.getDocuments();
    templist = collecttionSnapshot.documents;
    list = templist.map((DocumentSnapshot doc){
      return University.fromJson(doc.data);
    }).toList();
    return list;
   }
  

  



  
}