import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Carrer.dart';

class CarrerService{
  Future<Carrer> getCarrer(String name)async{
    CollectionReference collectionReference =
        Firestore.instance.collection('Carrer');
        QuerySnapshot qs = await collectionReference.where('carrer_name', isEqualTo: name).getDocuments();
        Carrer carrer = Carrer.fromJson(qs.documents[0].data);

      return await carrer;
        

  }
}