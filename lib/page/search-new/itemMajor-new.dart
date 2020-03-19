import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_guidance/model/Career.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/model/StudentFavorite.dart';
import 'package:student_guidance/page/search-new/itemCareer-new.dart';
import 'package:student_guidance/service/CareerService.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/service/StudentFavoriteService.dart';
import 'package:student_guidance/utils/UIdata.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemMajorNew extends StatefulWidget {
  final String universityName;
  final String facultyName;
  final DocumentSnapshot major;
  final List<StudentFavorite> listFavorite;

  const ItemMajorNew(
      {Key key,
      this.universityName,
      this.facultyName,
      this.major,
      this.listFavorite})
      : super(key: key);

  @override
  _ItemMajorNewState createState() => _ItemMajorNewState();
}

class _ItemMajorNewState extends State<ItemMajorNew>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> tabData;
  bool _isFollow;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 5);
    StudentFavorite favorite = widget.listFavorite.singleWhere(
        (favorite) =>
            favorite.university == widget.universityName &&
            favorite.faculty == widget.facultyName &&
            favorite.major == Major.fromJson(widget.major.data).majorName,
        orElse: () => null);
    _isFollow = favorite != null ? true : false;
    tabData = ['1', '2', '3', '4', '5'];
  }

  @override
  Widget build(BuildContext context) {
    final Major itemMajor = Major.fromJson(widget.major.data);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: ShaderMask(
              shaderCallback: (bound) => RadialGradient(
                      radius: 4.0,
                      colors: [Colors.yellow, Colors.white],
                      center: Alignment.topLeft,
                      tileMode: TileMode.clamp)
                  .createShader(bound),
              child: Shimmer.fromColors(
                  child: Text(
                    UIdata.txItemMajorTitle,
                    style: UIdata.textTitleStyle,
                  ),
                  baseColor: Colors.greenAccent,
                  highlightColor: Colors.red,
                  period: const Duration(milliseconds: 3000))),
          leading: ShaderMask(
              shaderCallback: (bound) => RadialGradient(
                      radius: 5.0,
                      colors: [Colors.greenAccent, Colors.blueAccent],
                      center: Alignment.topLeft,
                      tileMode: TileMode.clamp)
                  .createShader(bound),
              child: Shimmer.fromColors(
                child: IconButton(
                  icon: UIdata.backIcon,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                baseColor: Colors.greenAccent,
                highlightColor: Colors.blueAccent,
                period: const Duration(milliseconds: 3000),
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      itemMajor.majorName,
                      style: UIdata.textTitleStyleDarkBold27,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.facultyName,
                              style: UIdata.textTitleStyleDark,
                            ),
                            AutoSizeText(
                              widget.universityName,
                              style: UIdata.textTitleStyleDarkUninersity,
                              minFontSize: 8,
                              maxLines: 1,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        FlatButton.icon(
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: _isFollow ? Colors.green : Colors.red,
                              width: 2,
                            ),
                          ),
                          color: _isFollow ? Colors.green : Colors.white,
                          icon: Icon(
                            _isFollow
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            color: Colors.red,
                            size: 25,
                          ),
                          label: Text(
                            _isFollow ? 'ติดตามแล้ว' : 'ติดตามสาขา',
                            style: TextStyle(
                                fontSize: 14,
                                color: _isFollow ? Colors.white : Colors.red,
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            setState(() {
                              StudentFavorite favorite = StudentFavorite();
                              favorite.university = widget.universityName;
                              favorite.faculty = widget.facultyName;
                              favorite.major =
                                  Major.fromJson(widget.major.data).majorName;

                              _isFollow = !_isFollow;
                              _isFollow
                                  ? StudentFavoriteService()
                                      .addStudentFavorite(favorite)
                                  : StudentFavoriteService()
                                      .deleteStudentFavorite(favorite);
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'รอบที่เปิดรับ',
                          style:
                              TextStyle(color: Color(0xffFF9211), fontSize: 15),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: roundTcas(
                                  itemMajor.tcasEntranceRound.firstWhere(
                                          (tcas) => tcas.round == '1',
                                          orElse: () => null) !=
                                      null,
                                  '1'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: roundTcas(
                                  itemMajor.tcasEntranceRound.firstWhere(
                                          (tcas) => tcas.round == '2',
                                          orElse: () => null) !=
                                      null,
                                  '2'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: roundTcas(
                                  itemMajor.tcasEntranceRound.firstWhere(
                                          (tcas) => tcas.round == '3',
                                          orElse: () => null) !=
                                      null,
                                  '3'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: roundTcas(
                                  itemMajor.tcasEntranceRound.firstWhere(
                                          (tcas) => tcas.round == '4',
                                          orElse: () => null) !=
                                      null,
                                  '4'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: roundTcas(
                                  itemMajor.tcasEntranceRound.firstWhere(
                                          (tcas) => tcas.round == '5',
                                          orElse: () => null) !=
                                      null,
                                  '5'),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'วุฒิการศึกษา',
                              style: TextStyle(
                                  color: Color(0xffFF9211), fontSize: 15),
                            ),
                            Text(
                              '- ' + itemMajor.certificate,
                              style: TextStyle(
                                  color: Color(0xff939191),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'ระยะเวลาหลักสูตร',
                              style: TextStyle(
                                  color: Color(0xffFF9211), fontSize: 15),
                            ),
                            Text(
                              '- ' + itemMajor.courseDuration + ' ปี',
                              style: TextStyle(
                                  color: Color(0xff939191),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'ค่าเทอม',
                              style: TextStyle(
                                  color: Color(0xffFF9211), fontSize: 15),
                            ),
                            Text(
                              '- ' +
                                  NumberFormat().format(
                                      double.parse(itemMajor.tuitionFee)) +
                                  ' / ภาคเรียน',
                              style: TextStyle(
                                  color: Color(0xff939191),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(width: 110),
                        InkWell(
                          onTap: () => launch(
                              itemMajor.url.startsWith('https://') ||
                                      itemMajor.url.startsWith('http://')
                                  ? itemMajor.url
                                  : 'http://${itemMajor.url}'),
                          child: Text(
                            'ดูเพิ่มเติมเกี่ยวกับสาขา',
                            style: TextStyle(
                                color: Color(0xff939191), fontSize: 13),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 7,
                decoration: BoxDecoration(color: Color(0xffEBEBEB)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'การรับสมัคร',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff939191),
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: Color(0xffFF9211),
                        labelColor: Color(0xffFF9211),
                        unselectedLabelColor: Color(0xff939191),
                        isScrollable: true,
                        tabs: tabData
                            .map((round) => Tab(
                                  text: 'รอบ ' + round,
                                ))
                            .toList(),
                      ),
                    ),
                    Container(
                      height: 150.0,
                      child: TabBarView(
                        controller: _tabController,
                        children: tabData.map(
                          (round) {
                            Tcas tcas = itemMajor.tcasEntranceRound.firstWhere(
                                (tcas) => tcas.round == round,
                                orElse: () => null);

                            if (tcas != null) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Text(tcas.description,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xff4F4F4F),
                                            fontWeight: FontWeight.bold)),
                                    Column(
                                        children: tcas.examReference
                                            .map((data) => Text(data))
                                            .toList())
                                  ],
                                ),
                              );
                            } else {
                              return Column(
                                children: <Widget>[
                                  Text('ยังไม่เปิดรับสมัคร',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff4F4F4F),
                                          fontWeight: FontWeight.bold))
                                ],
                              );
                            }
                          },
                        ).toList(),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 7,
                decoration: BoxDecoration(color: Color(0xffEBEBEB)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text('อาชีพที่น่าสนใจในสาขานี้',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff4F4F4F),
                              fontWeight: FontWeight.bold)),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: itemMajor.listCareerName.map((career) {
                          return FutureBuilder<DocumentSnapshot>(
                            future:
                                CareerService().getCareerByCarrerName(career),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Career itemCareer =
                                    Career.fromJson(snapshot.data.data);
                                return careerItem(itemCareer, snapshot.data);
                              } else {
                                return Text(' - ไม่พบอาชีพที่เกี่ยวข้อง');
                              }
                            },
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 7,
                decoration: BoxDecoration(color: Color(0xffEBEBEB)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: Column(
                  children: <Widget>[
                    Text('รายละเอียดโรงเรียน',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff4F4F4F),
                            fontWeight: FontWeight.bold))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget careerItem(Career career, DocumentSnapshot docCareer) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemCarrerNew(career: docCareer)));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: FutureBuilder(
            future: GetImageService().getImage(career.image),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data),
                      radius: 40,
                    ),
                    AutoSizeText(
                      career.careerName,
                      maxLines: 2,
                    ),
                  ],
                );
              } else {
                return Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                    ),
                    Text(career.careerName),
                  ],
                );
              }
            }),
      ),
    );
  }

  Widget roundTcas(bool isOpen, String number) {
    int index = int.parse(number);
    return Container(
      width: 30,
      height: 30,
      child: RaisedButton(
        padding: EdgeInsets.all(0),
        shape: StadiumBorder(),
        textColor: isOpen == true ? Colors.white : Colors.black,
        color: isOpen == true ? Color(0xff006A82) : Color(0xff00BAE3),
        onPressed: () {
          setState(() {
            _tabController.index = index - 1;
          });
        },
        child: Text(
          number,
        ),
      ),
    );
  }
}
