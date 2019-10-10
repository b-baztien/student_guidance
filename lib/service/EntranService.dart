import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/EntranceExamResult.dart';

class EntranService {
  Future<List<EntranceExamResult>> getAllEntranceExamResult() async {
    List<DocumentSnapshot> templist;
    List<EntranceExamResult> list = new List();
    CollectionReference collectionReference =
        Firestore.instance.collection('EntranceExamResult');

    QuerySnapshot collecttionSnapshot =
        await collectionReference.getDocuments();
    print(collecttionSnapshot);
    templist = collecttionSnapshot.documents;
    list = templist.map((DocumentSnapshot doc) {
      return EntranceExamResult.fromJson(doc.data);
    }).toList();
    return list;
  }

  Future<Map<String, List<EntranceExamResult>>>
      getEntranceExamResultAnalyte() async {
    Map<String, List<EntranceExamResult>> data =
        new Map<String, List<EntranceExamResult>>();
    Set<String> listYear = new Set<String>();
    return await Firestore.instance
        .collection('EntranceExamResult')
        .orderBy('year')
        .getDocuments()
        .then((result) async {
      for (DocumentSnapshot doc in result.documents) {
        listYear.add(doc.data['year']);
      }

      for (String year in listYear) {
        List<EntranceExamResult> listExam = new List<EntranceExamResult>();
        await Firestore.instance
            .collection('EntranceExamResult')
            .orderBy('year')
            .reference()
            .where('year', isEqualTo: year)
            .getDocuments()
            .then((listResult) {
          for (DocumentSnapshot result in listResult.documents) {
            listExam.add(EntranceExamResult.fromJson(result.data));
          }
          data[year] = listExam;
        });
      }
      return data;
    });
  }

  addEntranceExamResult(EntranceExamResult enExam) async {
    Firestore.instance.collection('EntranceExamResult').add(enExam.toMap());
  }
}
