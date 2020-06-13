import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  bool _isScroll = true;

  String _dropdownZoneValue;
  String _dropdownProvinceValue;
  List _dropdownProvinceData = UIdata.provinceData;
  ScrollController _scrollController = ScrollController();
  DocumentSnapshot _lastDocument;
  bool _loadingPage = true;
  List<University> listUniversity = [];
  List<Faculty> listFaculty = [];
  List<Major> listMajor = [];
  List<DocumentSnapshot> _listDocumetSnapshot = [];
  _getItemSearch() async {
    try {
      setState(() {
        _loadingPage = true;
      });
      _getMoreItemSearch();

      setState(() {
        _loadingPage = false;
      });
    } catch (e) {
      rethrow;
    }
  }

  _getMoreItemSearch() async {
    List<String> _whereFields = [];
    List<String> _whereValue = [];
    if (_searchText.trim().isNotEmpty || _searchText.trim() != '') {
      if (type == 'University') {
        _whereFields.add('university_name');
      }
      _whereValue.add(_searchText);
    }
    if (_dropdownZoneValue != null) {
      _whereFields.add('zone');
      _whereValue.add(_dropdownZoneValue);
    }
    if (_dropdownProvinceValue != null) {
      _whereFields.add('province');
      _whereValue.add(_dropdownProvinceValue);
    }

    List<University> listUniversityMore = [];
    List<Major> listMajorMore = [];
    List<Faculty> listFacultyMore = [];

    if (_whereFields.isNotEmpty) {
      await _getFilterSearchItem(_whereFields, _whereValue);
      setState(() {
        if (type == 'University') {
          listUniversity = _listDocumetSnapshot
              .map((doc) => University.fromJson(doc.data))
              .toList();
        } else if (type == 'Major') {
          listMajor = _listDocumetSnapshot
              .map((doc) => Major.fromJson(doc.data))
              .toList();
        } else {
          listFaculty = _listDocumetSnapshot
              .map((doc) => Faculty.fromJson(doc.data))
              .toList();
        }
      });
    } else {
      _perPage = type == 'University' ? 5 : 10;
      QuerySnapshot querySnapshot = await SearchService()
          .getSearchItem(type, keyType, _lastDocument, _perPage);
      _listDocumetSnapshot.addAll(querySnapshot.documents);

      if (type == 'University') {
        listUniversityMore = querySnapshot.documents
            .map((doc) => University.fromJson(doc.data))
            .toList();
      } else if (type == 'Major') {
        listMajorMore = querySnapshot.documents
            .map((doc) => Major.fromJson(doc.data))
            .toList();
      } else {
        listFacultyMore = querySnapshot.documents
            .map((doc) => Faculty.fromJson(doc.data))
            .toList();
      }

      if (querySnapshot.documents.isEmpty) {
        _isScroll = false;
        return;
      }

      setState(() {
        if (type == 'University') {
          listUniversity.addAll(listUniversityMore);
        } else if (type == 'Major') {
          listMajor.addAll(listMajorMore);
        } else {
          listFaculty.addAll(listFacultyMore);
        }
        _lastDocument = querySnapshot.documents.last;
        _isScroll = true;
      });
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
    if (_dropdownZoneValue != null) {
      _whereFields.add('zone');
      _whereValue.add(_dropdownZoneValue);
    }
    if (_dropdownProvinceValue != null) {
      _whereFields.add('province');
      _whereValue.add(_dropdownProvinceValue);
    }

    countOrder = await SearchService()
        .countSearchItem(type, keyType, _whereFields, _whereValue);
  }

  _getFilterSearchItem(
      List<String> _whereFields, List<String> _whereValue) async {
    QuerySnapshot queryDocument =
        await SearchService().getAllSearchItem(type, keyType);
    for (var i = 0; i < _whereFields.length; i++) {
      for (var doc in queryDocument.documents) {
        String _fieldValue = doc.data[_whereFields[i]].toString();
        if (_fieldValue.contains(_whereValue[i])) {
          _listDocumetSnapshot.add(doc);
        }
      }
    }
    setState(() {
      _isScroll = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCountSearchItem();
    _getItemSearch();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;
      if (maxScroll - currentScroll <= delta && _isScroll) {
        _isScroll = false;
        _getMoreItemSearch();
      }
    });
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
                          setState(() {
                            _isScroll = true;
                          });
                          groupRadio = _curentRadio;
                          Navigator.pop(context);
                          if (_curentRadio == 1) {
                            setState(() {
                              listUniversity = [];
                              _listDocumetSnapshot = [];
                              listMajor = [];
                              listFaculty = [];
                              type = 'University';
                              keyType = 'university_name';
                              _getItemSearch();
                              _getCountSearchItem();
                            });
                          } else if (_curentRadio == 2) {
                            setState(() {
                              listUniversity = [];
                              listMajor = [];
                              listFaculty = [];
                              _listDocumetSnapshot = [];
                              type = 'Faculty';
                              keyType = 'faculty_name';
                              _getItemSearch();
                              _getCountSearchItem();
                            });
                          } else {
                            setState(() {
                              listUniversity = [];
                              _listDocumetSnapshot = [];
                              listMajor = [];
                              listFaculty = [];
                              type = 'Major';
                              keyType = 'majorName';
                              _getItemSearch();
                              _getCountSearchItem();
                            });
                          }
                        },
                      ),
                      RaisedButton(
                        child: Text(UIdata.btFiltterClose),
                        onPressed: () {
                          setState(() {
                            _curentRadio = groupRadio;
                            Navigator.pop(context);
                            print('Close');
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

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                return Scaffold(
                  key: _scaffordKey,
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title: ShaderMask(
                        shaderCallback: (bound) => RadialGradient(
                                radius: 5.0,
                                colors: [Colors.greenAccent, Colors.blueAccent],
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
                                _searchText = value.trim();
                                _listDocumetSnapshot = [];
                                await _getCountSearchItem();
                                await _getMoreItemSearch();
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                ShaderMask(
                                    shaderCallback: (bound) => RadialGradient(
                                            radius: 5.0,
                                            colors: [
                                              Colors.redAccent,
                                              Colors.blueAccent,
                                            ],
                                            center: Alignment.topLeft,
                                            tileMode: TileMode.mirror)
                                        .createShader(bound),
                                    child: Text(
                                        'พบทั้งหมด ' +
                                            countOrder.toString() +
                                            ' รายการ',
                                        style: TextStyle(
                                            color: UIdata.themeColor,
                                            fontFamily: UIdata.fontFamily))),
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
                          ? Container(
                              child: Center(
                              child: Text(
                                'กำลังโหลดข้อมูล...',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ))
                          : _listDocumetSnapshot.length == 0
                              ? Container(
                                  child: Center(
                                    child: Text('ไม่พบข้อมูล...'),
                                  ),
                                )
                              : Expanded(
                                  child: type == 'University'
                                      ? ListView.builder(
                                          controller: _scrollController,
                                          itemCount:
                                              _listDocumetSnapshot.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 150,
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.white,
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ItemUniversityNew(
                                                                    universitys:
                                                                        _listDocumetSnapshot[
                                                                            index]),
                                                          ),
                                                        );
                                                      },
                                                      child: Ink(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          10.0),
                                                              decoration: new BoxDecoration(
                                                                  border: new Border(
                                                                      right: new BorderSide(
                                                                          width:
                                                                              2.0,
                                                                          color:
                                                                              Color(0xff005BC7)))),
                                                              child:
                                                                  FutureBuilder(
                                                                      future: GetImageService().getImage(
                                                                          listUniversity[index]
                                                                              .image),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          return Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 3.2,
                                                                            decoration:
                                                                                BoxDecoration(
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
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              image: DecorationImage(
                                                                                image: AssetImage('assets/images/university-icon.png'),
                                                                                fit: BoxFit.fill,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }
                                                                      }),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                5),
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2,
                                                                    child:
                                                                        AutoSizeText(
                                                                      listUniversity[
                                                                              index]
                                                                          .universityname,
                                                                      style: UIdata
                                                                          .textSearchTitleStyle24Blue,
                                                                      minFontSize:
                                                                          10,
                                                                      maxLines:
                                                                          2,
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Icon(
                                                                        FontAwesomeIcons
                                                                            .mapMarkerAlt,
                                                                        color: Color(
                                                                            0xff005BC7),
                                                                        size:
                                                                            13,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            3,
                                                                      ),
                                                                      Text(
                                                                        "ภาค" +
                                                                            listUniversity[index].zone +
                                                                            " จังหวัด" +
                                                                            listUniversity[index].province,
                                                                        style: UIdata
                                                                            .textSearchSubTitleStyle13Blue,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  FutureBuilder(
                                                                    future: SearchService()
                                                                        .getCountAlumniEntranceMajor(
                                                                            listUniversity[index].universityname),
                                                                    builder: (BuildContext
                                                                            context,
                                                                        AsyncSnapshot<int>
                                                                            snapshot) {
                                                                      if (snapshot
                                                                          .hasData) {
                                                                        return Row(
                                                                          children: <
                                                                              Widget>[
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
                                                                                    'รุ่นพี่ ' + snapshot.data.toString() + ' คน เคยมาเรียนที่นี่',
                                                                                    style: UIdata.textSearchSubTitleStyle13Green,
                                                                                  )
                                                                                : Text(
                                                                                    'ยังไม่มีรุ่นพี่เคยมาเรียนที่นี่',
                                                                                    style: UIdata.textSearchSubTitleStyle13Red,
                                                                                  )
                                                                          ],
                                                                        );
                                                                      } else {
                                                                        return Text(
                                                                            '');
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
                                                Visibility(
                                                  visible: index ==
                                                          _listDocumetSnapshot
                                                                  .length -
                                                              1 &&
                                                      index != countOrder - 1,
                                                  child: Center(
                                                    child: Container(
                                                      width: 100,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/loading.gif'),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            );
                                          },
                                        )
                                      : type == 'Major'
                                          ? ListView.builder(
                                              controller: _scrollController,
                                              itemCount:
                                                  _listDocumetSnapshot.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          child: Material(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  10),
                                                            ),
                                                            child: ListTile(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ListUniversityMajor(majorName: listMajor[index].majorName)));
                                                                },
                                                                leading:
                                                                    Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              15.0),
                                                                  decoration: new BoxDecoration(
                                                                      border: new Border(
                                                                          right: new BorderSide(
                                                                              width: 1.0,
                                                                              color: Colors.black))),
                                                                  child:
                                                                      Container(
                                                                    width: 30,
                                                                    height: 30,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/images/icon-major.png'),
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                title: Text(
                                                                    listMajor[index]
                                                                        .majorName,
                                                                    style: UIdata
                                                                        .textSearchSubTitleStyle13Black),
                                                                trailing: Icon(
                                                                    Icons
                                                                        .keyboard_arrow_right,
                                                                    color: Colors
                                                                        .black,
                                                                    size:
                                                                        30.0)),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: index ==
                                                                  _listDocumetSnapshot
                                                                          .length -
                                                                      1 &&
                                                              index !=
                                                                  countOrder -
                                                                      1,
                                                          child: Center(
                                                            child: Container(
                                                              width: 120,
                                                              height: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/images/loading.gif'),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                              },
                                            )
                                          : ListView.builder(
                                              controller: _scrollController,
                                              itemCount:
                                                  _listDocumetSnapshot.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          child: Material(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  10),
                                                            ),
                                                            child: ListTile(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ListUniversityMajor(majorName: listFaculty[index].facultyName)));
                                                                },
                                                                leading:
                                                                    Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              15.0),
                                                                  decoration: new BoxDecoration(
                                                                      border: new Border(
                                                                          right: new BorderSide(
                                                                              width: 1.0,
                                                                              color: Colors.black))),
                                                                  child:
                                                                      Container(
                                                                    width: 30,
                                                                    height: 30,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/images/icon-major.png'),
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                title: Text(
                                                                    listFaculty[
                                                                            index]
                                                                        .facultyName,
                                                                    style: UIdata
                                                                        .textSearchSubTitleStyle13Black),
                                                                trailing: Icon(
                                                                    Icons
                                                                        .keyboard_arrow_right,
                                                                    color: Colors
                                                                        .black,
                                                                    size:
                                                                        30.0)),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: index ==
                                                                  _listDocumetSnapshot
                                                                          .length -
                                                                      1 &&
                                                              index !=
                                                                  countOrder -
                                                                      1,
                                                          child: Center(
                                                            child: Container(
                                                              width: 120,
                                                              height: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/images/loading.gif'),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                              },
                                            ))
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
                                colors: [Colors.greenAccent, Colors.blueAccent],
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
    );
  }

  Future<SharedPreferences> _getPrefs() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs;
  }
}
