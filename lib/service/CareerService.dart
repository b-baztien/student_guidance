import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Career.dart';

class CareerService {
  Future<DocumentSnapshot> getCareerByCarrerName(String name) async {
    CollectionReference collectionReference =
        Firestore.instance.collection('Career');
    QuerySnapshot qs = await collectionReference
        .where('career_name', isEqualTo: name)
        .getDocuments();
    return qs.documents.isNotEmpty ? qs.documents[0] : null;
  }

  Future<List<String>> getAllCareerName() async {
    CollectionReference careerSnapshot =
        Firestore.instance.collection('Career');
    return await careerSnapshot.getDocuments().then((snapshot) => snapshot
        .documents
        .map((doc) => Career.fromJson(doc.data).careerName)
        .toSet()
        .toList());
  }
}
