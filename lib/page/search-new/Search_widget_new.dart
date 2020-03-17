import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Career.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/FilterSeachItems.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/page/Search/ItemMajor.dart';
import 'package:student_guidance/page/drawer/Mydrawer.dart';
import 'package:student_guidance/page/search-new/ItemUniversity-new.dart';
import 'package:student_guidance/page/search-new/ListUniversity_Faculty.dart';
import 'package:student_guidance/page/search-new/ListUniversity_Major.dart';
import 'package:student_guidance/page/search/ItemFaculty.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/service/SearchService.dart';
import 'package:student_guidance/utils/UIdata.dart';
import 'package:shimmer/shimmer.dart';

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
  List<Color> list = [
    Colors.green,
    Colors.black,
    Colors.blue,
    Colors.deepOrange
  ];
  List<University> setListSize = new List<University>();

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
      width: 300,
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
              child: Swiper(
                autoplay: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(color: list[index]),
                  );
                },
                itemCount: list.length,
                pagination: new SwiperPagination(),
              ),
            )
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
                      Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 12.0, right: 12.0),
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
                                      contentPadding: EdgeInsets.only(
                                          left: 10.0, top: 12.0),
                                      hintText: UIdata.txSearchBox,
                                      hintStyle: TextStyle(color: Colors.grey),
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.clear),
                                        onPressed: () {
                                          setState(() {
                                            _searchTextController.clear();
                                            _searchText =
                                                _searchTextController.text;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
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
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemUniversityNew(
                                universitys: listItem[index].documentSnapshot),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
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
                                  future: GetImageService()
                                      .getImage(listUniversity[index].image),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.2,
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
                                            MediaQuery.of(context).size.width /
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
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
                  );
                },
              );
            } else if (type == 'Faculty') {
              return ListView.builder(
                itemCount: listItem.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListUniversityFaculty(
                                  facultys: listItem[index].name,
                                   )));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: Container(
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
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListUniversityMajor(
                                    majorName: listItem[index].name)));
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: Container(
                              child: ListTile(
                                  leading: Container(
                                    padding: EdgeInsets.only(right: 15.0),
                                    decoration: new BoxDecoration(
                                        border: new Border(
                                            right: new BorderSide(
                                                width: 1.0,
                                                color: Colors.black))),
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
                                      style: UIdata
                                          .textSearchSubTitleStyle13Black),
                                  trailing: Icon(Icons.keyboard_arrow_right,
                                      color: Colors.black, size: 30.0)))),
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
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemFaculty(
                                    facultyName: listItem[index].name)));
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: Center(
                            child: Container(
                                child: ListTile(
                                    leading: Container(
                                      padding: EdgeInsets.only(right: 15.0),
                                      decoration: new BoxDecoration(
                                          border: new Border(
                                              right: new BorderSide(
                                                  width: 3,
                                                  color:
                                                      Colors.deepOrange[700]))),
                                      child: FutureBuilder(
                                          future: GetImageService().getImage(
                                              listCareer[index].image),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Container(
                                                width: 55,
                                                height: 55,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          80.0),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        snapshot.data),
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
                                                      BorderRadius.circular(
                                                          80.0),
                                                ),
                                              );
                                            }
                                          }),
                                    ),
                                    title: Text(listItem[index].name,
                                        style: UIdata
                                            .textSearchTitleStyle20Orange),
                                    trailing: Icon(Icons.keyboard_arrow_right,
                                        color: Colors.red[900], size: 30.0))),
                          )),
                    ),
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
