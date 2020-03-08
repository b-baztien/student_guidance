import 'package:cloud_firestore/cloud_firestore.dart';

class CareerService {
  Future<QuerySnapshot> getCareerByCarrerName(String name) async {
    CollectionReference collectionReference =
        Firestore.instance.collection('Career');
    QuerySnapshot qs = await collectionReference
        .where('career_name', isEqualTo: name)
        .getDocuments();
    return qs;
  }
}
