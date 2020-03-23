import 'package:flutter/material.dart';
import 'package:student_guidance/service/MajorService.dart';
import 'package:student_guidance/utils/UIdata.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddRecommend extends StatefulWidget {
  @override
  _AddRecommendState createState() => _AddRecommendState();
}

class _AddRecommendState extends State<AddRecommend> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, bool> mapValues = new Map<String, bool>();
  List<String> listValue = List();
  @override
  void initState() {
    super.initState();
    MajorService().getAllMajorName().then((majorName) {
      for (String f in majorName) {
        setState(() {
          mapValues[f] = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Color(0xff003471)])),
          child: Scaffold(
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
                                  (val && listValue.length >= 3)
                                      ? _scaffoldKey.currentState.showSnackBar(
                                          UIdata.dangerSnackBar(
                                              'เพิ่มสูงสุดได้ 3 สาขา'))
                                      : setState(() {
                                          if (val) {
                                            mapValues[key] = true;
                                            listValue.add(key);
                                          } else {
                                            mapValues[key] = false;
                                            listValue.remove(key);
                                          }
                                        });
                                },
                                title: Text(key),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              );
                            }).toList())),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[],
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
