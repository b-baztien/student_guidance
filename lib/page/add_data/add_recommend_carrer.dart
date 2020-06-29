import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:student_guidance/model/StudentRecommend.dart';
import 'package:student_guidance/service/CareerService.dart';
import 'package:student_guidance/service/StudentReccommendService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class AddRecommendCarrer extends StatefulWidget {
  static String tag = 'add-recommend-carrer-page';

  @override
  _AddRecommendCarrerState createState() => _AddRecommendCarrerState();
}

class _AddRecommendCarrerState extends State<AddRecommendCarrer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, bool> mapValues = new Map<String, bool>();
  List<String> _listCareerName;
  StudentRecommend _recommend;
  List<String> tmpArray = [];
  ProgressDialog _progressDialog;
  StudentRecommend _stdRcm;
  TextEditingController _searchTextController = new TextEditingController();
  String _searchText = '';

  FocusNode myFocusNode;
  Timer _debounce;

  String navigatePageTag;

  int _allPage = 1;
  int _currentPage = 1;
  int _perPage = 10;

  @override
  void initState() {
    super.initState();
    _progressDialog =
        UIdata.buildLoadingProgressDialog(context, 'กำลังโหลด...');
    myFocusNode = FocusNode();
    loadData();
  }

  loadData() async {
    setState(() {
      _progressDialog.show();
    });
    _listCareerName = await CareerService().getAllCareerName();
    _recommend =
        await StudentRecommendService().getStudentRecommendByUsername();

    _getMoreData();

    setState(() {
      _progressDialog.hide();
    });
  }

  _getMoreData() {
    //initial data
    setState(() {
      int currentStartRecord = (_currentPage * _perPage) - (_perPage);
      int currentEndRecord = _currentPage * _perPage;

      List<String> filterCareers = List();

      mapValues = new Map<String, bool>();
      _stdRcm = null;

      //filter data
      filterCareers = _listCareerName
          .where((careerName) => careerName.contains(_searchText))
          .toList();

      _allPage = (filterCareers.length / _perPage).ceil();

      if (_currentPage * _perPage > filterCareers.length) {
        currentEndRecord = filterCareers.length;
      }

      //set data to show per page
      if (filterCareers.isNotEmpty) {
        filterCareers =
            filterCareers.sublist(currentStartRecord, currentEndRecord);
      }

      //set data to map
      for (String careerName in filterCareers) {
        mapValues[careerName] = false;
      }

      //set checkbox value
      _stdRcm = _recommend == null ? StudentRecommend() : _recommend;
      if (_recommend?.careerName != null)
        for (String careerName in _recommend.careerName) {
          if (tmpArray.isEmpty) {
            tmpArray = _recommend.careerName;
          }
          if (mapValues.containsKey(careerName)) {
            mapValues[careerName] = true;
          }
        }

      if (mapValues.isEmpty) {
        _allPage = 0;
        _currentPage = 0;
        return;
      }
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
      setState(() {
        _progressDialog.show();
      });
      _stdRcm.careerName = tmpArray;
      await StudentRecommendService().addEditStudentRecommend(_stdRcm);
      setState(() {
        _progressDialog.hide();
        if (navigatePageTag != null) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            navigatePageTag,
            ModalRoute.withName(navigatePageTag),
          );
        } else {
          Navigator.pop(context, 'ดำเนินการสำเร็จ');
        }
      });
    } catch (e) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState
          .showSnackBar(UIdata.dangerSnackBar('ดำเนินข้อมูลล้มเหลว'));
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    navigatePageTag = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Color(0xff003471)]),
          ),
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            body: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Center(
                  child: Text(
                    UIdata.txRecommendCarrer,
                    style: UIdata.textTitleStyle24,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 12.0, right: 12.0, bottom: 10.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      controller: _searchTextController,
                      focusNode: myFocusNode,
                      onChanged: (value) {
                        setState(() async {
                          if (_debounce?.isActive ?? false) {
                            _debounce.cancel();
                          }
                          _debounce =
                              Timer(Duration(milliseconds: 1000), () async {
                            _searchText = value.trim();
                            _allPage = 1;
                            _currentPage = 1;
                            await loadData();
                          });
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: UIdata.themeColor,
                          size: 25.0,
                        ),
                        contentPadding: EdgeInsets.only(left: 10.0, top: 12.0),
                        hintText: UIdata.txSearchBox,
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() async {
                              _searchTextController.clear();
                              _searchText = _searchTextController.text;
                              await loadData();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 2, color: Colors.white)),
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Container(
                                  child: mapValues.isEmpty
                                      ? Text('ไม่พบข้อมูล')
                                      : Column(
                                          children:
                                              mapValues.keys.map((String key) {
                                            return CheckboxListTile(
                                              value: mapValues[key],
                                              onChanged: (bool val) {
                                                if (val &&
                                                    tmpArray.length >= 3) {
                                                  _scaffoldKey.currentState
                                                      .hideCurrentSnackBar();
                                                  _scaffoldKey.currentState
                                                      .showSnackBar(
                                                          UIdata.dangerSnackBar(
                                                              'เพิ่มสูงสุดได้ 3 อาชีพ'));
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
                                                  ListTileControlAffinity
                                                      .trailing,
                                            );
                                          }).toList(),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 12.0, right: 12.0, bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          padding: EdgeInsets.all(12),
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.blueGrey,
                          textColor: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.chevronLeft,
                              ),
                              Text(
                                'ย้อนกลับ',
                              ),
                            ],
                          ),
                          color: Color(0xffC70039),
                          onPressed: _currentPage != 1
                              ? () {
                                  _currentPage--;
                                  _getMoreData();
                                }
                              : null,
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          padding: EdgeInsets.all(12),
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.blueGrey,
                          textColor: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'ถัดไป',
                              ),
                              Icon(
                                FontAwesomeIcons.chevronRight,
                              ),
                            ],
                          ),
                          color: Color(0xff27AE60),
                          onPressed: _currentPage != _allPage
                              ? () {
                                  _currentPage++;
                                  _getMoreData();
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flex(
                    direction: Axis.horizontal,
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
                        highlightColor: Colors.green,
                        onPressed: () async {
                          await getCheckbox();
                        },
                        icon: Icon(
                          FontAwesomeIcons.save,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: Text(
                          'บันทึก',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
