import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/FacultyService.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/service/MajorService.dart';
import 'package:student_guidance/service/SearchService.dart';
import 'package:student_guidance/utils/UIdata.dart';
import 'package:student_guidance/widgets/swiper_pagination.dart';

class ItemUniversityNew extends StatefulWidget {
  final DocumentSnapshot universitys;

  const ItemUniversityNew({Key key, this.universitys}) : super(key: key);
  @override
  _ItemUniversityNewState createState() => _ItemUniversityNewState();
}

class _ItemUniversityNewState extends State<ItemUniversityNew> {
  University _university = new University();
  List<Color> list = [
    Colors.white,
    Colors.black,
    Colors.blue,
    Colors.deepOrange
  ];
  @override
  void initState() {
    super.initState();
    _university = University.fromJson(widget.universitys.data);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Material(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/university-bg.png'),
            fit: BoxFit.cover,
          )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
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
                        UIdata.txItemUniversityTitle,
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
              child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black.withOpacity(0.5),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                //Icon University
                                FutureBuilder(
                                  future: GetImageService()
                                      .getImage(_university.image),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        height: 130.0,
                                        width: 130.0,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    NetworkImage(snapshot.data),
                                                fit: BoxFit.fitHeight)),
                                      );
                                    } else {
                                      return Container(
                                        height: 130.0,
                                        width: 130.0,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/University-Icon.png'),
                                                fit: BoxFit.cover)),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: 5),
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: AutoSizeText(
                                        _university.universityname,
                                        style: UIdata.textTitleStyle,
                                        minFontSize: 10,
                                        maxLines: 2,
                                      ),
                                    ),
                                    FutureBuilder(
                                      future: SearchService()
                                          .getCountAlumniEntranceMajor(
                                              _university.universityname),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<int> snapshot) {
                                        if (snapshot.hasData) {
                                          return Row(
                                            children: <Widget>[
                                              Icon(
                                                  FontAwesomeIcons.userGraduate,
                                                  color: Colors.white),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'รุ่นพี่ ' +
                                                    snapshot.data.toString() +
                                                    ' คน เคยเรียนที่นี่',
                                                style: UIdata
                                                    .textDashboardSubTitleStyle12White,
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Row(
                                            children: <Widget>[
                                              Icon(
                                                  FontAwesomeIcons.userGraduate,
                                                  color: Colors.white),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'กำลังโหลด...',
                                                style: UIdata
                                                    .textDashboardSubTitleStyle12White,
                                              ),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: 180,
                                                child:
                                                    _buildBottomNavigationMenu(
                                                        _university),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            30),
                                                    topRight:
                                                        const Radius.circular(
                                                            30),
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        padding: const EdgeInsets.all(9),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.blueAccent),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.idCard,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            Text(
                                              UIdata.txContectUniversityButton,
                                              style: UIdata
                                                  .textDashboardSubTitleStyle12White,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _university.albumImage.length != 0
                                ? itemListImage(_university.albumImage)
                                : SizedBox(
                                    height: 1,
                                  ),
                            detailUniversity(_university.universitydetail)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                UIdata.txDeatilUniversityGroupFaculty,
                                style: UIdata.textTitleStyle,
                              ),
                            ),
                            StreamBuilder<List<DocumentSnapshot>>(
                                stream: FacultyService()
                                    .getListFacultyByUniversityId(
                                        widget.universitys.documentID),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      children: snapshot.data.map(
                                        (facultyDoc) {
                                          Faculty faculty =
                                              Faculty.fromJson(facultyDoc.data);
                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Container(
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.white),
                                                child: Container(
                                                  child: ListTile(
                                                    leading: Container(
                                                      width: 40.0,
                                                      height: 40.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(80.0),
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .orange),
                                                        child: Icon(
                                                          IconData(
                                                              int.parse(faculty
                                                                  .facultyIcon
                                                                  .codePoint),
                                                              fontFamily: faculty
                                                                  .facultyIcon
                                                                  .fontFamily),
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    title: StreamBuilder<
                                                            List<
                                                                DocumentSnapshot>>(
                                                        stream: MajorService()
                                                            .getMajorByFacultyReference(
                                                                facultyDoc
                                                                    .reference),
                                                        builder: (context,
                                                            mjSnapshot) {
                                                          if (mjSnapshot
                                                              .hasData) {
                                                            return Text(
                                                              faculty.facultyName +
                                                                  faculty
                                                                      .facultyName +
                                                                  (mjSnapshot.data
                                                                              .length >
                                                                          0
                                                                      ? ' (' +
                                                                          mjSnapshot
                                                                              .data
                                                                              .length
                                                                              .toString() +
                                                                          ' สาขา)'
                                                                      : ''),
                                                              style: UIdata
                                                                  .textSubTitleStyleDark,
                                                            );
                                                          }
                                                          return Text(
                                                            faculty.facultyName +
                                                                faculty
                                                                    .facultyName,
                                                            style: UIdata
                                                                .textSubTitleStyleDark,
                                                          );
                                                        }),
                                                    trailing: Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        color: Colors.black,
                                                        size: 30.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    );
                                  } else {
                                    return Text(
                                      'not fount',
                                      style: UIdata.textSubTitleStyle,
                                    );
                                  }
                                })
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget detailUniversity(String deital) {
    return Container(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        child: Text(
          deital,
          style: UIdata.textDashboardTitleStyle15White,
        ),
      ),
    );
  }

  Widget itemListImage(List<dynamic> listImg) {
    return FutureBuilder(
      future: GetImageService().getListImage(listImg),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: 150,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Swiper(
                autoplayDelay: Duration(seconds: 10).inMilliseconds,
                duration: Duration(seconds: 2).inMilliseconds,
                autoplay: snapshot.data.length == 1 ? false : true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                              image: NetworkImage(snapshot.data[index]),
                              fit: BoxFit.cover)));
                },
                itemCount: snapshot.data.length,
                pagination: SwiperPagination(
                  builder: CustomePaginationBuilder(
                      activeSize: Size(15, 25),
                      size: Size(10, 20),
                      color: Colors.grey.shade300,
                      activeColor: Colors.green),
                ),
              ),
            ),
          );
        } else {
          return SizedBox(
            height: 1,
          );
        }
      },
    );
  }
}

Column _buildBottomNavigationMenu(University university) {
  return Column(
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.phone),
        title: Text(university.phoneNO),
      ),
      ListTile(
        leading: Icon(Icons.http),
        title: Text(university.url),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text(university.address +
            " " +
            university.tambon +
            " " +
            university.amphur +
            " " +
            university.province +
            " " +
            university.zipcode),
      )
    ],
  );
}
