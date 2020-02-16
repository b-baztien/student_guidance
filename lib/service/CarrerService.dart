import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Career.dart';

class CarrerService{
  Future<Career> getCarrer(String name)async{
    CollectionReference collectionReference =
        Firestore.instance.collection('Carrer');
        QuerySnapshot qs = await collectionReference.where('carrer_name', isEqualTo: name).getDocuments();
        Career carrer = Career.fromJson(qs.documents[0].data);

      return carrer;
  }
}