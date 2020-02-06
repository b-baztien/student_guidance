import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:student_guidance/model/News.dart';

class NewsService {
  Future getNews() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('News').getDocuments();
    return qn.documents;
  }

  Stream<List<News>> getAllNewsBySchoolName(
      String schoolName, DateTime dateTime) {
    String formattedDateStart =
        DateFormat('yyyy-MM-dd' + ' 00:00:00').format(dateTime);
    String formattedDateEnd =
        DateFormat('yyyy-MM-dd' + ' 23:59:59').format(dateTime);
    DateTime startTime = DateTime.parse(formattedDateStart);
    DateTime endTime = DateTime.parse(formattedDateEnd);

    Query collectionReference = Firestore.instance
        .collectionGroup('News')
        .where('schoolName', isEqualTo: schoolName)
        .where('start_time',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startTime))
        .where('start_time',
            isLessThanOrEqualTo: Timestamp.fromDate(endTime));

    return collectionReference.snapshots().map((snapshot) {
      print('length ' + snapshot.documentChanges.length.toString());
      return snapshot.documentChanges.map((docChange) {
        return News.fromJson(docChange.document.data);
      }).toList();
    });
  }

  Future<String> getImage(String path) async {
    String url;
    try {
      StorageReference ref = FirebaseStorage.instance.ref().child(path);
      url = await ref.getDownloadURL().then((image) async {
        return image.toString();
      });

      return url;
    } catch (e) {
      rethrow;
    }
  }
}
