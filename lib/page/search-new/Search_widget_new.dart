import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_guidance/model/Career.dart';
import 'package:student_guidance/model/FilterSeachItems.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/RecommendMajor.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/page/drawer/Mydrawer.dart';
import 'package:student_guidance/page/search-new/ItemUniversity-new.dart';
import 'package:student_guidance/page/search-new/ListUniversity_Faculty.dart';
import 'package:student_guidance/page/search-new/ListUniversity_Major.dart';
import 'package:student_guidance/page/search-new/itemCareer-new.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/service/SearchService.dart';
import 'package:student_guidance/service/StudentReccommendService.dart';
import 'package:student_guidance/utils/UIdata.dart';
import 'package:student_guidance/widgets/swiper_pagination.dart';

class SearchWidgetNew extends StatefulWidget {
  @override
  _SearchWidgetNewState createState() => _SearchWidgetNewState();
}

class _SearchWidgetNewState extends State<SearchWidgetNew> {
  var _scaffordKey = new GlobalKey<ScaffoldState>();
  String type = 'University';
  int coutOrder = 0;
  int _curentRadio = 1;
  int groupRadio = 1;
  TextEditingController _searchTextController = new TextEditingController();
  String _searchText = '';
  Login _login;
  List<University> setListSize = new List<University>();

  String _dropdownZoneValue;
  String _dropdownProvinceValue;
  List _dropdownProvinceData = UIdata.provinceData;

  @override
  void initState() {
    super.initState();
    SearchService().getAllSearchItem().listen((data) {
      List<FilterSeachItems> list = data;
      List<FilterSeachItems> listItem = new List<FilterSeachItems>();
      for (FilterSeachItems f in list) {
        if (f.type == type) {
          listItem.add(f);
        }
      }
      setState(() {
        coutOrder = listItem.length;
      });
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
            _buildDivider(),
            itemFilter(UIdata.txFilterItemCareer, 4),
            SizedBox(
              height: 40,
            ),
            Text(
              UIdata.txFilterRecommend,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            itemRecommend(),
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

                          if (_curentRadio == 1) {
                            setState(() {
                              type = 'University';
                            });
                          } else if (_curentRadio == 2) {
                            setState(() {
                              type = 'Faculty';
                            });
                          } else if (_curentRadio == 3) {
                            setState(() {
                              type = 'Major';
                            });
                          } else {
                            setState(() {
                              type = 'Career';
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

  Widget itemRecommend() {
    return Container(
        height: 150,
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: DiagonalPathClipperOne(),
              child: Container(
                height: 140,
                color: Colors.deepPurple,
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder(
                  future: StudentRecommendService().getRecommendMajor(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<RecommendMajor> list = snapshot.data;
                      return list.length == 1
                          ? Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                decoration: new BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(
                                        1.0,
                                        1.0,
                                      ),
                                    )
                                  ],
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 150,
                                child: Material(
                                  borderRadius: BorderRadius.circular(5),
                                  shadowColor: Colors.red,
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Ink(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            decoration: new BoxDecoration(
                                                border: new Border(
                                                    right: new BorderSide(
                                                        width: 2.0,
                                                        color: Color(
                                                            0xff005BC7)))),
                                            child: FutureBuilder<String>(
                                                future: GetImageService()
                                                    .getImage(list[0].img),
                                                initialData: null,
                                                builder: (context, snapshot) {
                                                  return Container(
                                                    width: 110,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: snapshot.hasData
                                                            ? NetworkImage(
                                                                snapshot.data)
                                                            : AssetImage(
                                                                'assets/images/University-Icon.png'),
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(top: 5),
                                                  child: AutoSizeText(
                                                    list[0].university,
                                                    style: TextStyle(
                                                        fontFamily: 'Kanit',
                                                        color:
                                                            Color(0xff005BC7)),
                                                    minFontSize: 15,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.school,
                                                      color: Color(0xff005BC7),
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      list[0].faculty,
                                                      style: TextStyle(
                                                        fontFamily: 'Kanit',
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xff005BC7),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .userGraduate,
                                                      color: Color(0xff005BC7),
                                                      size: 13,
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      list[0].major,
                                                      style: TextStyle(
                                                          fontFamily: 'Kanit',
                                                          fontSize: 13,
                                                          color: Colors.green),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Swiper(
                              autoplayDelay:
                                  Duration(seconds: 5).inMilliseconds,
                              autoplay: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                    decoration: new BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 5.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(
                                            1.0,
                                            1.0,
                                          ),
                                        )
                                      ],
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(5),
                                      shadowColor: Colors.red,
                                      color: Colors.white,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Ink(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(
                                                    right: 10.0),
                                                decoration: new BoxDecoration(
                                                  border: new Border(
                                                    right: new BorderSide(
                                                        width: 2.0,
                                                        color:
                                                            Color(0xff005BC7)),
                                                  ),
                                                ),
                                                child: FutureBuilder<String>(
                                                    future: GetImageService()
                                                        .getImage(
                                                            list[index].img),
                                                    initialData: null,
                                                    builder:
                                                        (context, snapshot) {
                                                      return Container(
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: snapshot
                                                                    .hasData
                                                                ? NetworkImage(
                                                                    snapshot
                                                                        .data)
                                                                : AssetImage(
                                                                    'assets/images/University-Icon.png'),
                                                            fit: BoxFit
                                                                .fitHeight,
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                      child: AutoSizeText(
                                                        list[index].university,
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: Color(
                                                                0xff005BC7)),
                                                        minFontSize: 15,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.school,
                                                          color:
                                                              Color(0xff005BC7),
                                                          size: 15,
                                                        ),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text(
                                                          list[index].faculty,
                                                          style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            fontSize: 13,
                                                            color: Color(
                                                                0xff005BC7),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .userGraduate,
                                                          color:
                                                              Color(0xff005BC7),
                                                          size: 13,
                                                        ),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text(
                                                          list[index].major,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Kanit',
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      ],
                                                    )
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
                              itemCount: list.length,
                              pagination: SwiperPagination(
                                  builder: CustomePaginationBuilder(
                                      activeSize: Size(15, 25),
                                      size: Size(10, 20),
                                      color: Colors.grey.shade300,
                                      activeColor: Colors.green)),
                            );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                                offset: Offset(
                                  1.0,
                                  1.0,
                                ),
                              )
                            ],
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          child: Material(
                              borderRadius: BorderRadius.circular(5),
                              shadowColor: Colors.red,
                              color: Colors.white,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('ไม่พบข้อมูลที่ตรงกัน !'),
                              )),
                        ),
                      );
                    }
                  },
                ))
          ],
        ));
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
                              setState(() {
                                _searchText = value;
                                _searchText = _searchText.trim();
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
                                  setState(() {
                                    _searchTextController.clear();
                                    _searchText = _searchTextController.text;
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
                                            coutOrder.toString() +
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
                      _buildExpendedSearch(type)
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

  Widget _buildExpendedSearch(String type) {
    return Expanded(
      child: StreamBuilder(
        stream: SearchService().getAllSearchItem(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<FilterSeachItems> list = snapshot.data;
            List<FilterSeachItems> listItem = new List<FilterSeachItems>();
            for (FilterSeachItems f in list) {
              if (f.type == type) {
                if (f.name.contains(_searchText)) {
                  listItem.add(f);
                }
              }
            }

            coutOrder = listItem.length;
            if (type == 'University') {
              List<University> listUniversity = new List<University>();
              //filter zone
              if (_dropdownZoneValue != null) {
                listItem = listItem
                    .where((fItem) => fItem.uZone == _dropdownZoneValue)
                    .toList();
                coutOrder = listItem.length;
              }
              //filter province
              if (_dropdownProvinceValue != null) {
                listItem = listItem
                    .where((fItem) => fItem.uProvince == _dropdownProvinceValue)
                    .toList();
                coutOrder = listItem.length;
              }
              for (FilterSeachItems filterSeachItems in listItem) {
                University university =
                    University.fromJson(filterSeachItems.documentSnapshot.data);
                listUniversity.add(university);
              }
              return ListView.builder(
                itemCount: listItem.length,
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
                                    universitys:
                                        listItem[index].documentSnapshot),
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
                                              width: 2.0,
                                              color: Color(0xff005BC7)))),
                                  child: FutureBuilder(
                                      future: GetImageService().getImage(
                                          listUniversity[index].image),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.2,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                    NetworkImage(snapshot.data),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.2,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/University-Icon.png'),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top: 5),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: AutoSizeText(
                                          listUniversity[index].universityname,
                                          style:
                                              UIdata.textSearchTitleStyle24Blue,
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
                                            style: UIdata
                                                .textSearchSubTitleStyle13Blue,
                                          ),
                                        ],
                                      ),
                                      FutureBuilder(
                                        future: SearchService()
                                            .getCountAlumniEntranceMajor(
                                                listUniversity[index]
                                                    .universityname),
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
                                                            snapshot.data
                                                                .toString() +
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
            } else if (type == 'Faculty') {
              return ListView.builder(
                itemCount: listItem.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListUniversityFaculty(
                                        facultys: listItem[index].name,
                                      )));
                        },
                        child: ListTile(
                          leading: Container(
                            padding: EdgeInsets.only(right: 10.0),
                            decoration: new BoxDecoration(
                                border: new Border(
                                    right: new BorderSide(
                                        width: 1.0, color: Colors.black))),
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/icon-faculty.png'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(80.0),
                              ),
                            ),
                          ),
                          title: Text(listItem[index].name,
                              style: UIdata.textSearchSubTitleStyle13Black),
                          trailing: Icon(Icons.keyboard_arrow_right,
                              color: Colors.black, size: 30.0),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (type == 'Major') {
              return ListView.builder(
                itemCount: listItem.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
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
                                        majorName: listItem[index].name)));
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
                                  image: AssetImage(
                                      'assets/images/icon-major.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          title: Text(listItem[index].name,
                              style: UIdata.textSearchSubTitleStyle13Black),
                          trailing: Icon(Icons.keyboard_arrow_right,
                              color: Colors.black, size: 30.0)),
                    ),
                  );
                },
              );
            } else {
              List<Career> listCareer = new List<Career>();
              for (FilterSeachItems filterSeachItems in listItem) {
                listCareer.add(
                    Career.fromJson(filterSeachItems.documentSnapshot.data));
              }
              return ListView.builder(
                itemCount: listItem.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Material(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        child: ListTile(
                            contentPadding: EdgeInsets.all(20),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ItemCarrerNew(
                                            career: listItem[index]
                                                .documentSnapshot,
                                          )));
                            },
                            leading: Container(
                              padding: EdgeInsets.only(right: 15.0),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                      right: new BorderSide(
                                          width: 3,
                                          color: Colors.deepOrange[700]))),
                              child: FutureBuilder(
                                  future: GetImageService()
                                      .getImage(listCareer[index].image),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        width: 55,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          image: DecorationImage(
                                            image: NetworkImage(snapshot.data),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        width: 55.0,
                                        height: 55.0,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/career.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                        ),
                                      );
                                    }
                                  }),
                            ),
                            title: Text(listItem[index].name,
                                style: UIdata.textSearchTitleStyle20Orange),
                            trailing: Icon(Icons.keyboard_arrow_right,
                                color: Colors.red[900], size: 30.0))),
                  );
                },
              );
            }
          } else {
            return SizedBox(height: 1);
          }
        },
      ),
    );
  }

  Future<SharedPreferences> _getPrefs() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs;
  }
}
