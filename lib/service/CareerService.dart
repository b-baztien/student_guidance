import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Career.dart';

class CareerService {
  Future<DocumentSnapshot> getCareerByCarrerName(String name) async {
    CollectionReference collectionReference =
        Firestore.instance.collection('Career');
    QuerySnapshot qs = await collectionReference
        .where('career_name', isEqualTo: name)
        .getDocuments();

    return qs.documents[0];
  }
}
