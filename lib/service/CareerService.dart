import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Career.dart';

class CareerService {
  Future<Career> getCareer(String name) async {
    CollectionReference collectionReference =
        Firestore.instance.collection('Career');
    QuerySnapshot qs = await collectionReference
        .where('career_name', isEqualTo: name)
        .getDocuments();
    Career career = Career.fromJson(qs.documents[0].data);

    return career;
  }
}
