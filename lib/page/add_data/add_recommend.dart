import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:student_guidance/model/StudentRecommend.dart';
import 'package:student_guidance/service/MajorService.dart';
import 'package:student_guidance/service/StudentReccommendService.dart';
import 'package:student_guidance/utils/UIdata.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddRecommend extends StatefulWidget {
  @override
  _AddRecommendState createState() => _AddRecommendState();
}

class _AddRecommendState extends State<AddRecommend> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, bool> mapValues = new Map<String, bool>();
  List<String> tmpArray = List();
  ProgressDialog _progressDialog;
  StudentRecommend _stdRcm;

  @override
  void initState() {
    super.initState();
    _progressDialog = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    _progressDialog.style(message: 'กำลังโหลด...');

    MajorService().getAllMajorName().then((majorName) {
      StudentRecommendService()
          .getStudentRecommendByUsername()
          .then((recommend) {
        for (String f in majorName) {
          setState(() {
            mapValues[f] = false;
          });
        }
        _stdRcm = recommend;
        for (String f in recommend.majorName) {
          setState(() {
            tmpArray = recommend.majorName;
            mapValues[f] = true;
          });
        }
      });
    });
  }

  getCheckbox() async {
    try {
      if (tmpArray.isEmpty) {
        _scaffoldKey.currentState.hideCurrentSnackBar();
        _scaffoldKey.currentState.showSnackBar(
            UIdata.dangerSnackBar('กรุณาเลือกสาขาอย่างน้อย 1 สาขา'));
        return;
      }
      _progressDialog.show();
      _stdRcm = StudentRecommend();
      _stdRcm.majorName = tmpArray;
      await StudentRecommendService()
          .addEditStudentRecommend(_stdRcm)
          .then((result) {
        _progressDialog.hide();
        Navigator.pop(context, 'ดำเนินการสำเร็จ');
      });
    } catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(UIdata.dangerSnackBar('ดำเนินข้อมูลล้มเหลว'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Color(0xff003471)])),
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 8, left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Text(
                        UIdata.txRecommend,
                        style: UIdata.textTitleStyle24,
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              border:
                                  Border.all(width: 2, color: Colors.white)),
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Container(
                                child: Column(
                                    children: mapValues.keys.map((String key) {
                              return CheckboxListTile(
                                value: mapValues[key],
                                onChanged: (bool val) {
                                  if (val && tmpArray.length >= 3) {
                                    _scaffoldKey.currentState
                                        .hideCurrentSnackBar();
                                    _scaffoldKey.currentState.showSnackBar(
                                        UIdata.dangerSnackBar(
                                            'เพิ่มสูงสุดได้ 3 สาขา'));
                                  } else {
                                    setState(() {
                                      if (val) {
                                        mapValues[key] = true;
                                        tmpArray.add(key);
                                      } else {
                                        mapValues[key] = false;
                                        tmpArray.remove(key);
                                      }
                                    });
                                  }
                                },
                                title: Text(key),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              );
                            }).toList())),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.exclamationCircle,
                                  color: Colors.white,
                                ),
                                onPressed: () {}),
                            FlatButton.icon(
                                shape: StadiumBorder(
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                onPressed: () {
                                  getCheckbox();
                                },
                                icon: Icon(
                                  FontAwesomeIcons.save,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                label: Text(
                                  'บันทึก',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
