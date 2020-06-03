import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_guidance/model/DashboardAlumni.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/page/drawer/Mydrawer.dart';
import 'package:student_guidance/service/DashboardService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class Dashboard extends StatefulWidget {
  static String tag = "dashboard-page";

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  TabController _tabController;
  List<String> tabData;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: FutureBuilder(
          future: UIdata.getPrefs(),
          builder: (context, futureSnapshot) {
            if (futureSnapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: ShaderMask(
                      shaderCallback: (bound) => RadialGradient(
                              radius: 4.0,
                              colors: [Colors.greenAccent, Colors.white],
                              center: Alignment.topLeft,
                              tileMode: TileMode.clamp)
                          .createShader(bound),
                      child: Shimmer.fromColors(
                          child: Text(
                            UIdata.txDashboardWidget,
                            style: UIdata.textTitleStyle,
                          ),
                          baseColor: Colors.white,
                          highlightColor: Colors.red,
                          period: const Duration(milliseconds: 3000))),
                ),
                drawer: MyDrawer(
                    login: Login.fromJson(
                        jsonDecode(futureSnapshot.data.getString('login'))),
                    student: Student.fromJson(
                        jsonDecode(futureSnapshot.data.getString('student'))),
                    schoolId: futureSnapshot.data.getString('schoolId')),
                body: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          UIdata.txDashboardTitle,
                          style: UIdata.textTitleStyleDark,
                        ),
                        StreamBuilder(
                          stream: DashboardService().getAlumniDashboard(
                            futureSnapshot.data.getString('schoolId'),
                          ),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<DashboardAlumni>> snapshot) {
                            if (snapshot.hasData) {
                              return FutureBuilder(
                                future: DashboardService().getDashboardYear(
                                    futureSnapshot.data.getString('schoolId')),
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    _tabController = new TabController(
                                        vsync: this, length: snap.data.length);
                                    tabData = snap.data;
                                    return Column(
                                      children: <Widget>[
                                        Container(
                                          child: TabBar(
                                            controller: _tabController,
                                            indicatorColor: Colors.green,
                                            labelColor: Colors.green,
                                            unselectedLabelColor:
                                                Color(0xff939191),
                                            isScrollable: true,
                                            tabs: tabData
                                                .map((year) => Tab(
                                                      text:
                                                          'ปีการศึกษา ' + year,
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                        Container(
                                          height: screenHeight,
                                          child: TabBarView(
                                            controller: _tabController,
                                            children: tabData.map(
                                              (year) {
                                                return Column(
                                                  children: <Widget>[
                                                    Column(
                                                      children: snapshot.data
                                                          .map(
                                                            (dashboardAlumni) => dashboardAlumni
                                                                        .graduateYear ==
                                                                    year
                                                                ? cardDashboradYear(
                                                                    dashboardAlumni)
                                                                : SizedBox
                                                                    .shrink(),
                                                          )
                                                          .toList(),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          _buildCardTop5(
                                                              Colors.black87,
                                                              screenWidth / 2.1,
                                                              UIdata
                                                                  .txDashnoardUniversityPop,
                                                              UIdata
                                                                  .textDashboardTitleStylePink,
                                                              UIdata
                                                                  .imgDashnoardUniversityPop,
                                                              40,
                                                              27,
                                                              DashboardService()
                                                                  .getDashboardUniversity(
                                                                      futureSnapshot
                                                                          .data
                                                                          .getString(
                                                                              'schoolId'),
                                                                      year)),
                                                          _buildCardTop5(
                                                              Color(0xffF08201),
                                                              screenWidth / 2.5,
                                                              UIdata
                                                                  .txDashnoardFacultyPop,
                                                              UIdata
                                                                  .textDashboardTitleStyleDark,
                                                              UIdata
                                                                  .imgDashnoardFacultyPop,
                                                              30,
                                                              30,
                                                              DashboardService()
                                                                  .getDashboardFaculty(
                                                                      futureSnapshot
                                                                          .data
                                                                          .getString(
                                                                              'schoolId'),
                                                                      year))
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15,
                                                              bottom: 15),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          _buildCardTop5(
                                                              Color(0xff006A82),
                                                              screenWidth - 37,
                                                              UIdata
                                                                  .txDashnoardMajorPop,
                                                              UIdata
                                                                  .textDashboardTitleStyleWhite,
                                                              UIdata
                                                                  .imgDashnoardMajorPop,
                                                              30,
                                                              30,
                                                              DashboardService()
                                                                  .getDashboardMajor(
                                                                      futureSnapshot
                                                                          .data
                                                                          .getString(
                                                                              'schoolId'),
                                                                      year)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ).toList(),
                                          ),
                                        )
                                      ],
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text(
                    UIdata.txDashboardWidget,
                    style: UIdata.textTitleStyle,
                  ),
                ),
                drawer: MyDrawer(),
              );
            }
          }),
    );
  }

  Widget cardDashboradYear(DashboardAlumni dashboardAlumni) {
    return Card(
        child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                UIdata.txDashboardStudentAll,
                style: UIdata.textSubTitleStyle_12,
              ),
              //นักเรียนทั้งหมด
              Text(
                dashboardAlumni.total.toString(),
                style: TextStyle(
                    fontFamily: 'Kanit', fontSize: 15, color: Colors.green),
              )
            ],
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            children: <Widget>[
              Text(
                UIdata.txDashboardStudentAddUniversity,
                style: UIdata.textSubTitleStyle_12,
              ),
              //ศึกษาต่อ
              Text(
                dashboardAlumni.studying.toString(),
                style: TextStyle(
                    fontFamily: 'Kanit', fontSize: 15, color: Colors.lightBlue),
              )
            ],
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            children: <Widget>[
              Text(
                UIdata.txDashboardStudentNoneUniversity,
                style: UIdata.textSubTitleStyle_12,
              ),
              //ไม่ศึกษาต่อ
              Text(
                dashboardAlumni.working.toString(),
                style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 15,
                    color: Colors.deepOrangeAccent),
              )
            ],
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            children: <Widget>[
              Text(
                UIdata.txDashboardStudentOther,
                style: UIdata.textSubTitleStyle_12,
              ),
              //อื่นๆ
              Text(
                dashboardAlumni.other.toString(),
                style: TextStyle(
                    fontFamily: 'Kanit', fontSize: 15, color: Colors.red),
              )
            ],
          )
        ],
      ),
    ));
  }

  Widget _buildCardTop5(
      Color color,
      double widthLayout,
      String title,
      TextStyle titleStyle,
      String assetImage,
      double widthImg,
      double hightImg,
      Future<List<String>> futureData) {
    return FutureBuilder<List<String>>(
        future: futureData,
        initialData: [],
        builder: (context, snapshot) {
          return Container(
            width: widthLayout,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    title,
                    minFontSize: 18,
                    style: titleStyle,
                  ),
                  Container(
                    child: snapshot.data != null
                        ? Column(
                            children: snapshot.data
                                .map(
                                  (data) => AutoSizeText(
                                    data,
                                    minFontSize: 15,
                                    style:
                                        UIdata.textDashboardSubTitleStyleWhite,
                                  ),
                                )
                                .toList(),
                          )
                        : Text(
                            'ไม่พบบข้อมูล',
                            style: UIdata.textDashboardSubTitleStyleWhite,
                          ),
                  ),
                  Align(
                    alignment: FractionalOffset.bottomRight,
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Container(
                          width: widthImg,
                          height: hightImg,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(assetImage),
                                fit: BoxFit.fill),
                          ),
                        )),
                  )
                ],
              ),
            ),
          );
        });
  }
}
