import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Major.dart';

class MajorService {
  Stream<List<DocumentSnapshot>> getAllMajor() {
    Stream<QuerySnapshot> majorSnapshot =
        Firestore.instance.collectionGroup('Major').snapshots();
    return majorSnapshot.map((mjSnapShot) => mjSnapShot.documents);
  }

  Future<List<Major>> getListMajor(List<dynamic> major) async {
    List<DocumentReference> list = new List<DocumentReference>();
    for (int i = 0; i < major.length; i++) {
      list.add(major[i]);
    }
    List<Major> listmajor = new List<Major>();
    for (DocumentReference df in list) {
      DocumentReference refQuery = df;
      Major mj = await refQuery.get().then((major) async {
        return Major.fromJson(major.data);
      });
      listmajor.add(mj);
    }
    return listmajor;
  }
}
