import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Major.dart';

class CareerService {
  Future<DocumentSnapshot> getCareerByCarrerName(String name) async {
    CollectionReference collectionReference =
        Firestore.instance.collection('Career');
    QuerySnapshot qs = await collectionReference
        .where('career_name', isEqualTo: name)
        .getDocuments();
    return qs.documents.isNotEmpty ? qs.documents[0] : null;
  }

  Future<List<String>> getAllCareerNameInMajor() async {
    Query majorSnapshot = Firestore.instance.collectionGroup('Major');
    Set<String> setCareerName = new Set();
    await majorSnapshot.getDocuments().then((snapshot) => {
          for (var doc in snapshot.documents)
            {setCareerName.addAll(Major.fromJson(doc.data).listCareerName)}
        });
    List<String> listSortedCareerName = setCareerName.toList();
    listSortedCareerName.sort((a, b) => a.compareTo(b));
    return listSortedCareerName;
  }
}
