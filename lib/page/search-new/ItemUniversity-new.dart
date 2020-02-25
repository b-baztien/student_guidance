import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/service/SearchService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ItemUniversityNew extends StatefulWidget {
  final DocumentSnapshot universitys;

  const ItemUniversityNew({Key key, this.universitys}) : super(key: key);
  @override
  _ItemUniversityNewState createState() => _ItemUniversityNewState();
}

class _ItemUniversityNewState extends State<ItemUniversityNew> {
  University _university = new University();
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
              title: Text(
                UIdata.txItemUniversityTitle,
                style: UIdata.textTitleStyle,
              ),
              leading: IconButton(
                icon: UIdata.backIcon,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: screenWidth,
                        height: screenHeight / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black.withOpacity(0.5),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          direction: Axis.vertical,
                          children: <Widget>[
                            Column(
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
                                            height: 150.0,
                                            width: 150.0,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        snapshot.data),
                                                    fit: BoxFit.fitHeight)),
                                          );
                                        } else {
                                          return Container(
                                            height: 150.0,
                                            width: 150.0,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          _university.universityname,
                                          style: UIdata.textTitleStyle24,
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
                                                      FontAwesomeIcons
                                                          .userGraduate,
                                                      color: Colors.white),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'รุ่นพี่ ' +
                                                        snapshot.data
                                                            .toString() +
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
                                                      FontAwesomeIcons
                                                          .userGraduate,
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
                                                        topLeft: const Radius
                                                            .circular(30),
                                                        topRight: const Radius
                                                            .circular(30),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 120,
                                            padding: const EdgeInsets.all(9),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.blueAccent),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Icon(
                                                  FontAwesomeIcons.idCard,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                Text(
                                                  UIdata
                                                      .txContectUniversityButton,
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
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: screenWidth,
                        height: screenHeight / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black.withOpacity(0.5),
                        ),
                        padding: const EdgeInsets.all(8.0),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
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
