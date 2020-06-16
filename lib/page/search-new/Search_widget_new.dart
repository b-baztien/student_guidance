import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/page/drawer/Mydrawer.dart';
import 'package:student_guidance/page/search-new/ItemUniversity-new.dart';
import 'package:student_guidance/page/search-new/ListUniversity_Major.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/service/SearchService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class SearchWidgetNew extends StatefulWidget {
  @override
  _SearchWidgetNewState createState() => _SearchWidgetNewState();
}

class _SearchWidgetNewState extends State<SearchWidgetNew> {
  var _scaffordKey = new GlobalKey<ScaffoldState>();
  String type = 'University';
  String keyType = 'university_name';
  int countOrder = 0;
  int _curentRadio = 1;
  int groupRadio = 1;
  int _perPage = 5;
  TextEditingController _searchTextController = new TextEditingController();
  String _searchText = '';
  List<University> setListSize = new List<University>();
  bool _showToTopBtn = false;

  int _allPage = 1;
  int _currentPage = 1;

  String _dropdownZoneValue;
  String _dropdownProvinceValue;
  List _dropdownProvinceData = UIdata.provinceData;
  DocumentSnapshot _lastDocument;
  bool _loadingPage = true;
  List<University> listUniversity = [];
  List<Faculty> listFaculty = [];
  List<Major> listMajor = [];
  List<DocumentSnapshot> _listDocumetSnapshot = [];

  ProgressDialog _progressDialog;

  _getItemSearch() async {
    try {
      await _getMoreItemSearch();
      setState(() {
        _loadingPage = false;
      });
    } catch (e) {
      rethrow;
    }
  }

  _getMoreItemSearch() async {
    _perPage = type == 'University' ? 5 : 10;
    int currentStartRecord = (_currentPage * _perPage) - (_perPage);
    int currentEndRecord = _currentPage * _perPage;

    if (currentEndRecord > _listDocumetSnapshot.length) {
      setState(() {
        _progressDialog.show();
      });
      QuerySnapshot querySnapshot = await SearchService()
          .getSearchItem(type, keyType, _lastDocument, _perPage);
      _listDocumetSnapshot.addAll(querySnapshot.documents);
    }

    if (!_loadingPage && _currentPage * _perPage > countOrder) {
      currentEndRecord = countOrder;
    }

    setState(() {
      if (type == 'University') {
        listUniversity = _listDocumetSnapshot
            .sublist(currentStartRecord, currentEndRecord)
            .map((doc) => University.fromJson(doc.data))
            .toList();
      } else if (type == 'Major') {
        listMajor = _listDocumetSnapshot
            .sublist(currentStartRecord, currentEndRecord)
            .map((doc) => Major.fromJson(doc.data))
            .toList();
      } else {
        listFaculty = _listDocumetSnapshot
            .sublist(currentStartRecord, currentEndRecord)
            .map((doc) => Faculty.fromJson(doc.data))
            .toList();
      }
      _lastDocument = _listDocumetSnapshot.last;
      _progressDialog.hide();
    });

    if (_listDocumetSnapshot.isEmpty) {
      _allPage = 0;
      _currentPage = 0;
      return;
    }
  }

  _getCountSearchItem() async {
    List<String> _whereFields = [];
    List<String> _whereValue = [];
    if (_searchText.trim().isNotEmpty) {
      if (type == 'University') {
        _whereFields.add('university_name');
      }
      _whereValue.add(_searchText);
    }
    if (_dropdownProvinceValue != null) {
      _whereFields.add('province');
      _whereValue.add(_dropdownProvinceValue);
    } else if (_dropdownZoneValue != null) {
      _whereFields.add('zone');
      _whereValue.add(_dropdownZoneValue);
    }

    countOrder = await SearchService()
        .countSearchItem(type, keyType, _whereFields, _whereValue);

    _allPage = (countOrder / _perPage).ceil();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      listUniversity = [];
      _listDocumetSnapshot = [];
      listMajor = [];
      listFaculty = [];
    });
    _progressDialog =
        UIdata.buildLoadingProgressDialog(context, 'กำลังโหลด...');
    _getCountSearchItem();
    _getItemSearch();
  }

  Widget myFilterDrawer() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
          color: Colors.white, boxShadow: [BoxShadow(color: Colors.black45)]),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              UIdata.txFiltterTitle,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(UIdata.txFilterType),
            itemFilter(UIdata.txFilterItemUniversity, 1),
            _buildDivider(),
            itemFilter(UIdata.txFilterItemFaculty, 2),
            _buildDivider(),
            itemFilter(UIdata.txFilterItemMajor, 3),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.green,
                        child: Text(
                          UIdata.btFiltterSuccess,
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          groupRadio = _curentRadio;
                          Navigator.pop(context);
                          setState(() {
                            listUniversity = [];
                            _listDocumetSnapshot = [];
                            listMajor = [];
                            listFaculty = [];
                            _allPage = 1;
                            _currentPage = 1;
                            _loadingPage = true;
                            if (_curentRadio == 1) {
                              type = 'University';
                              keyType = 'university_name';
                            } else if (_curentRadio == 2) {
                              type = 'Faculty';
                              keyType = 'faculty_name';
                            } else {
                              type = 'Major';
                              keyType = 'majorName';
                            }
                            _getCountSearchItem();
                            _getItemSearch();
                          });
                        },
                      ),
                      RaisedButton(
                        child: Text(UIdata.btFiltterClose),
                        onPressed: () {
                          setState(() {
                            _curentRadio = groupRadio;
                            Navigator.pop(context);
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemFilter(String txTypeFilter, int value) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(txTypeFilter),
          Radio(
              value: value,
              groupValue: _curentRadio,
              activeColor: Colors.pink,
              onChanged: (int T) {
                setState(() {
                  _curentRadio = T;
                });
              })
        ],
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: Colors.indigo,
    );
  }

//University List
  Widget _buildUniversityList() {
    return ListView.builder(
      itemCount: listUniversity.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Material(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemUniversityNew(
                          universitys: _listDocumetSnapshot.firstWhere((doc) =>
                              doc.data[keyType] ==
                              listUniversity[index].universityname)),
                    ),
                  );
                },
                child: Ink(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 10.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(
                                    width: 2.0, color: Color(0xff005BC7)))),
                        child: FutureBuilder(
                            future: GetImageService()
                                .getImage(listUniversity[index].image),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.2,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.2,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/university-icon.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              }
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              width: MediaQuery.of(context).size.width / 2,
                              child: AutoSizeText(
                                listUniversity[index].universityname,
                                style: UIdata.textSearchTitleStyle24Blue,
                                minFontSize: 10,
                                maxLines: 2,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.mapMarkerAlt,
                                  color: Color(0xff005BC7),
                                  size: 13,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "ภาค" +
                                      listUniversity[index].zone +
                                      " จังหวัด" +
                                      listUniversity[index].province,
                                  style: UIdata.textSearchSubTitleStyle13Blue,
                                ),
                              ],
                            ),
                            FutureBuilder(
                              future: SearchService()
                                  .getCountAlumniEntranceMajor(
                                      listUniversity[index].universityname),
                              builder: (BuildContext context,
                                  AsyncSnapshot<int> snapshot) {
                                if (snapshot.hasData) {
                                  return Row(
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.userGraduate,
                                        color: Color(0xff005BC7),
                                        size: 13,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      snapshot.data > 0
                                          ? Text(
                                              'รุ่นพี่ ' +
                                                  snapshot.data.toString() +
                                                  ' คน เคยมาเรียนที่นี่',
                                              style: UIdata
                                                  .textSearchSubTitleStyle13Green,
                                            )
                                          : Text(
                                              'ยังไม่มีรุ่นพี่เคยมาเรียนที่นี่',
                                              style: UIdata
                                                  .textSearchSubTitleStyle13Red,
                                            )
                                    ],
                                  );
                                } else {
                                  return Text('');
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

//List Major
  Widget _buildMajorList() {
    return ListView.builder(
      itemCount: listMajor.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              child: Material(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListUniversityMajor(
                                  majorName: listMajor[index].majorName)));
                    },
                    leading: Container(
                      padding: EdgeInsets.only(right: 15.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.black))),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/icon-major.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    title: Text(listMajor[index].majorName,
                        style: UIdata.textSearchSubTitleStyle13Black),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.black, size: 30.0)),
              ),
            ));
      },
    );
  }

//List Faculty
  Widget _buildFacultyList() {
    return ListView.builder(
      itemCount: listFaculty.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              child: Material(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListUniversityMajor(
                                  majorName: listFaculty[index].facultyName)));
                    },
                    leading: Container(
                      padding: EdgeInsets.only(right: 15.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.black))),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/icon-major.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    title: Text(listFaculty[index].facultyName,
                        style: UIdata.textSearchSubTitleStyle13Black),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.black, size: 30.0)),
              ),
            ));
      },
    );
  }

  //Counter Item Text
  Widget _buildCounterItem() {
    String text;
    int firstItem = ((_currentPage * _perPage) - (_perPage - 1));
    int lastItem;

    if (_currentPage * _perPage > countOrder) {
      lastItem = countOrder;
    } else {
      lastItem = (_currentPage * _perPage);
    }

    text = 'รายการที่ ';

    if (firstItem != lastItem) {
      text += firstItem.toString() + ' - ' + lastItem.toString();
    } else {
      text += firstItem.toString();
    }

    text += ' จากทั้งหมด ' + countOrder.toString() + ' รายการ';
    return Text(
      text,
      style: TextStyle(color: UIdata.themeColor, fontFamily: UIdata.fontFamily),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: _showToTopBtn,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.navigation),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/thembg.png"),
                // <-- BACKGROUND IMAGE
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: FutureBuilder(
              future: _getPrefs(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var shaderMask = ShaderMask(
                      shaderCallback: (bound) => RadialGradient(
                              radius: 5.0,
                              colors: [
                                Colors.redAccent,
                                Colors.blueAccent,
                              ],
                              center: Alignment.topLeft,
                              tileMode: TileMode.mirror)
                          .createShader(bound),
                      child: _buildCounterItem());
                  return Scaffold(
                    key: _scaffordKey,
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      title: ShaderMask(
                          shaderCallback: (bound) => RadialGradient(
                                  radius: 5.0,
                                  colors: [
                                    Colors.greenAccent,
                                    Colors.blueAccent
                                  ],
                                  center: Alignment.topLeft,
                                  tileMode: TileMode.clamp)
                              .createShader(bound),
                          child: Shimmer.fromColors(
                            child: Text(
                              UIdata.txSearchWidget,
                              style: UIdata.textTitleStyle,
                            ),
                            baseColor: Colors.greenAccent,
                            highlightColor: Colors.blueAccent,
                          )),
                      actions: <Widget>[Container()],
                    ),
                    drawer: MyDrawer(
                        student: Student.fromJson(
                            jsonDecode(snapshot.data.getString('student'))),
                        login: Login.fromJson(
                            jsonDecode(snapshot.data.getString('login'))),
                        schoolId: snapshot.data.getString('schoolId')),
                    endDrawer: myFilterDrawer(),
                    drawerEdgeDragWidth: 0,
                    body: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 12.0, right: 12.0, bottom: 10.0),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(10.0),
                            child: TextField(
                              controller: _searchTextController,
                              onChanged: (value) {
                                setState(() async {
                                  Timer(Duration(milliseconds: 800), () async {
                                    _searchText = value.trim();
                                    _listDocumetSnapshot = [];
                                    await _getCountSearchItem();
                                    await _getMoreItemSearch();
                                  });
                                });
                              },
                              //  controller: _controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: UIdata.themeColor,
                                  size: 25.0,
                                ),
                                contentPadding:
                                    EdgeInsets.only(left: 10.0, top: 12.0),
                                hintText: UIdata.txSearchBox,
                                hintStyle: TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() async {
                                      _searchTextController.clear();
                                      _searchText = _searchTextController.text;
                                      _listDocumetSnapshot = [];
                                      await _getCountSearchItem();
                                      await _getMoreItemSearch();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _curentRadio == 1,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                  left: 26, top: 5, bottom: 5, right: 5),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  DropdownButton<String>(
                                    value: _dropdownZoneValue,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _dropdownZoneValue = newValue;
                                        _dropdownProvinceValue = null;
                                        _listDocumetSnapshot = [];
                                        _getMoreItemSearch();
                                        _getCountSearchItem();
                                      });
                                    },
                                    hint: DropdownMenuItem<String>(
                                      value: null,
                                      child: Text('ทุกภาค'),
                                    ),
                                    items: _dropdownProvinceData
                                        .map((provinceData) =>
                                            provinceData['zone'] as String)
                                        .toSet()
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  DropdownButton<String>(
                                    value: _dropdownProvinceValue,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _dropdownProvinceValue = newValue;
                                        _listDocumetSnapshot = [];
                                        _getMoreItemSearch();
                                        _getCountSearchItem();
                                      });
                                    },
                                    hint: DropdownMenuItem<String>(
                                      value: null,
                                      child: Text('ทุกจังหวัด'),
                                    ),
                                    items: _dropdownProvinceData
                                        .map((provinceData) {
                                          if (_dropdownZoneValue == null) {
                                            return provinceData['province_name']
                                                as String;
                                          }
                                          if (provinceData['zone'] ==
                                              _dropdownZoneValue) {
                                            return provinceData['province_name']
                                                as String;
                                          }
                                          return null;
                                        })
                                        .where((provinceName) =>
                                            provinceName != null)
                                        .toList()
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        })
                                        .toList(),
                                  ),
                                ],
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                  left: 26, top: 5, bottom: 5, right: 5),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  shaderMask,
                                  IconButton(
                                    icon: Icon(
                                      Icons.filter_list,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      _scaffordKey.currentState.openEndDrawer();
                                      setState(() {
                                        _curentRadio = groupRadio;
                                      });
                                    },
                                  )
                                ],
                              )),
                        ),
                        _loadingPage == true
                            ? Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/loading.gif',
                                      height: 200,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'กำลังโหลด...',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Kanit',
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : _listDocumetSnapshot.length == 0
                                ? Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/not-found.gif',
                                          height: 200,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'ไม่พบข้อมูล',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Kanit',
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        if (type == 'University')
                                          Expanded(
                                              child: _buildUniversityList())
                                        else if (type == 'Major')
                                          Expanded(child: _buildMajorList())
                                        else
                                          Expanded(child: _buildFacultyList()),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: FlatButton(
                                                padding: EdgeInsets.all(12),
                                                disabledColor: Colors.grey,
                                                disabledTextColor:
                                                    Colors.blueGrey,
                                                textColor: Colors.white,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .chevronLeft,
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
                                                        _getMoreItemSearch();
                                                      }
                                                    : null,
                                              ),
                                            ),
                                            Expanded(
                                              child: FlatButton(
                                                padding: EdgeInsets.all(12),
                                                disabledColor: Colors.grey,
                                                disabledTextColor:
                                                    Colors.blueGrey,
                                                textColor: Colors.white,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      'ถัดไป',
                                                    ),
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .chevronRight,
                                                    ),
                                                  ],
                                                ),
                                                color: Color(0xff27AE60),
                                                onPressed:
                                                    _currentPage != _allPage
                                                        ? () {
                                                            _currentPage++;
                                                            _getMoreItemSearch();
                                                          }
                                                        : null,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                      ],
                    ),
                  );
                } else {
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      title: ShaderMask(
                          shaderCallback: (bound) => RadialGradient(
                                  radius: 5.0,
                                  colors: [
                                    Colors.greenAccent,
                                    Colors.blueAccent
                                  ],
                                  center: Alignment.topLeft,
                                  tileMode: TileMode.clamp)
                              .createShader(bound),
                          child: Text(
                            UIdata.txSearchWidget,
                            style: UIdata.textTitleStyle,
                          )),
                    ),
                    drawer: Drawer(
                      elevation: 0,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Future<SharedPreferences> _getPrefs() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs;
  }
}
