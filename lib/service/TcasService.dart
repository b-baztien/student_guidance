import 'package:cloud_firestore/cloud_firestore.dart';

class TcasService {
  Future<List<DocumentSnapshot>> getListTcasByMajorRef(
      DocumentReference majorRef) async {
    try {
      Query query = Firestore.instance
          .document(majorRef.path)
          .collection('Tcas')
          .orderBy('round');
      List<DocumentSnapshot> listTcas =
          await query.getDocuments().then((doc) async {
        return doc.documents;
      }).catchError((onError) {
        return null;
      });
      return listTcas;
    } catch (e) {
      rethrow;
    }
  }
}
