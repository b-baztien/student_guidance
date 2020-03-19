import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/ChartData.dart';
import 'package:student_guidance/model/EntranceExamResult.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/StudentService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class EntranService {
  Future<List<EntranceExamResult>> getAllEntranceExamResult() async {
    List<DocumentSnapshot> templist;
    List<EntranceExamResult> list = new List();
    CollectionReference collectionReference =
        Firestore.instance.collection('EntranceExamResult');

    QuerySnapshot collecttionSnapshot =
        await collectionReference.getDocuments();
    templist = collecttionSnapshot.documents;
    list = templist.map((DocumentSnapshot doc) {
      return EntranceExamResult.fromJson(doc.data);
    }).toList();
    return list;
  }

  Future<Map<String, Map<int, List<ChartData>>>> getDashboard(int id) async {
    Map<String, Map<int, List<ChartData>>> chartData =
        new Map<String, Map<int, List<ChartData>>>();
    Set<String> setYear = new Set<String>();
    Set<DocumentReference> setUni = new Set<DocumentReference>();
    Set<DocumentReference> setFac = new Set<DocumentReference>();
    Set<DocumentReference> setMj = new Set<DocumentReference>();

    Student student = await StudentService().getStudent().then((result) {
      return result;
    });

    return await Firestore.instance
        .collection('EntranceExamResult')
        // .where('school', isEqualTo: student.school)
        .getDocuments()
        .then((result) async {
      for (DocumentSnapshot doc in result.documents) {
        setYear.add(doc.data['year']);
        setUni.add(doc.data['university']);
        setFac.add(doc.data['faculty']);
        setMj.add(doc.data['major']);
      }

      for (String year in setYear) {
        Query fireExam = Firestore.instance
            .collection('EntranceExamResult')
            .where('year', isEqualTo: year);

        switch (id) {
          case 1:
            {
              List<ChartData> listChartData = new List<ChartData>();
              Map<int, List<ChartData>> chartUniData =
                  new Map<int, List<ChartData>>();

              for (DocumentReference uni in setUni) {
                await fireExam
                    .where('university', isEqualTo: uni)
                    .getDocuments()
                    .then((listResult) async {
                  ChartData chData = new ChartData();
                  if (listResult.documents.length != 0) {
                    University uniData = await uni.get().then((result) {
                      return University.fromJson(result.data);
                    });
                    chData.name = uniData.universityname;
                    chData.value = listResult.documents.length.toDouble();
                    chData.year = year;
                    listChartData.add(chData);
                  }
                });
              }
              chartUniData[1] = listChartData;
              chartData[year] = chartUniData;
            }
            break;
          case 2:
            {
              List<ChartData> listChartData = new List<ChartData>();
              Map<int, List<ChartData>> chartFacData =
                  new Map<int, List<ChartData>>();

              for (DocumentReference fac in setFac) {
                await fireExam
                    .where('faculty', isEqualTo: fac)
                    .getDocuments()
                    .then((listResult) async {
                  ChartData chData = new ChartData();
                  if (listResult.documents.length != 0) {
                    Faculty facData = await fac.get().then((result) {
                      return Faculty.fromJson(result.data);
                    });
                    chData.name = facData.facultyName;
                    chData.value = listResult.documents.length.toDouble();
                    chData.year = year;
                    listChartData.add(chData);
                  }
                });
              }
              chartFacData[2] = listChartData;
              chartData[year] = chartFacData;
            }
            break;
          case 3:
            {
              List<ChartData> listChartData = new List<ChartData>();
              Map<int, List<ChartData>> chartMjData =
                  new Map<int, List<ChartData>>();

              for (DocumentReference mj in setMj) {
                await fireExam
                    .where('major', isEqualTo: mj)
                    .getDocuments()
                    .then((listResult) async {
                  ChartData chData = new ChartData();
                  if (listResult.documents.length != 0) {
                    Major mjData = await mj.get().then((result) {
                      return Major.fromJson(result.data);
                    });
                    chData.name = mjData.majorName;
                    chData.value = listResult.documents.length.toDouble();
                    chData.year = year;
                    listChartData.add(chData);
                  }
                });
              }
              chartMjData[3] = listChartData;
              chartData[year] = chartMjData;
            }
            break;
          case 4:
            {
              List<ChartData> listChartData = new List<ChartData>();
              Map<int, List<ChartData>> chartUniData =
                  new Map<int, List<ChartData>>();
              for (DocumentReference fac in setFac) {
                await fireExam
                    .where('faculty', isEqualTo: fac)
                    .getDocuments()
                    .then((listResult) async {
                  ChartData chData = new ChartData();
                  if (listResult.documents.length != 0) {
                    Faculty facData = await fac.get().then((result) {
                      return Faculty.fromJson(result.data);
                    });
                    chData.name = facData.facultyName;
                    chData.value = listResult.documents.length.toDouble();
                    chData.year = year;
                    listChartData.add(chData);
                  }
                });
              }
              chartUniData[2] = listChartData;
              chartData[year] = chartUniData;
            }
            break;
        }
      }
      return chartData;
    });
  }

  Future<bool> addEntranceExamResult(EntranceExamResult enExam) async {
    try {
      SharedPreferences preferences = await UIdata.getPrefs();
      Login login = Login.fromJson(jsonDecode(preferences.getString('login')));
      return Firestore.instance
          .collectionGroup('Login')
          .where('username', isEqualTo: login.username)
          .getDocuments()
          .then((loginDoc) async {
        if (loginDoc.documents[0] == null) return false;
        await loginDoc.documents[0].reference
            .parent()
            .parent()
            .collection('EntranceExamResult')
            .add(enExam.toMap());
        return true;
      });
    } catch (error) {
      rethrow;
    }
  }
}
