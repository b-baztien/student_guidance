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
import 'package:student_guidance/page/search-new/itemMajor-new.dart';
import 'package:student_guidance/service/MajorService.dart';
import 'package:student_guidance/service/StudentFavoriteService.dart';
import 'package:student_guidance/utils/UIdata.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemFacultyNew extends StatefulWidget {
  final Faculty facultys;
  final String universityName;
  final DocumentReference docFac;

  const ItemFacultyNew(
      {Key key, this.facultys, this.universityName, this.docFac})
      : super(key: key);
  @override
  _ItemFacultyNewState createState() => _ItemFacultyNewState();
}

class _ItemFacultyNewState extends State<ItemFacultyNew> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Material(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/faculty-bg.png'),
            fit: BoxFit.cover,
          )),
          child: FutureBuilder<SharedPreferences>(
              future: UIdata.getPrefs(),
              builder: (context, pref) {
                return Scaffold(
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
                              UIdata.txItemFacultyTitle,
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
                      child: Ink(
                        width: screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black.withOpacity(0.5),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 130.0,
                                  width: 130.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orange,
                                      border: Border.all(
                                          color: Colors.white, width: 3)),
                                  child: Icon(
                                    IconData(
                                        int.parse(widget
                                            .facultys.facultyIcon.codePoint),
                                        fontFamily: widget
                                            .facultys.facultyIcon.fontFamily),
                                    color: Colors.white,
                                    size: 85,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.only(top: 5),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Column(
                                          children: <Widget>[
                                            AutoSizeText(
                                              widget.facultys.facultyName,
                                              style: UIdata.textTitleStyle24,
                                              minFontSize: 10,
                                              maxLines: 2,
                                            ),
                                            Divider(
                                              color: Colors.white,
                                            ),
                                          ],
                                        )),
                                    Container(
                                      padding: EdgeInsets.only(top: 5),
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: AutoSizeText(
                                          widget.universityName,
                                          style: UIdata.textTitleStyle,
                                          minFontSize: 5,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      child: FlatButton.icon(
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(
                                          FontAwesomeIcons.globeAsia,
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          UIdata.txWebside,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Color(0xff27AE60),
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(8.0)),
                                        onPressed: () {
                                          launch(widget.facultys.url);
                                        },
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    UIdata.txMajorGroup,
                                    style: UIdata.textTitleStyle,
                                  ),
                                  StreamBuilder<List<DocumentSnapshot>>(
                                      stream: MajorService()
                                          .getMajorByFacultyReference(
                                              widget.docFac),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Column(
                                            children:
                                                snapshot.data.map((majorDoc) {
                                              Major major =
                                                  Major.fromJson(majorDoc.data);
                                              return Container(
                                                margin: EdgeInsets.only(top: 4.0),
                                                child: Ink(
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.white),
                                                  child: ListTile(
                                                    onTap: () {
                                                      StudentFavoriteService()
                                                          .getStudentFavoriteByUsername(
                                                              Login.fromJson(jsonDecode(pref
                                                                      .data
                                                                      .getString(
                                                                          'login')))
                                                                  .username)
                                                          .then((listFavorite) {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ItemMajorNew(
                                                              universityName: widget
                                                                  .universityName,
                                                              facultyName: widget
                                                                  .facultys
                                                                  .facultyName,
                                                              major: majorDoc,
                                                              listFavorite:
                                                                  listFavorite,
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                    },
                                                    leading: Container(
                                                      width: 40.0,
                                                      height: 40.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.orange,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                80.0),
                                                      ),
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .graduationCap,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    title: Text(
                                                      major.majorName,
                                                      style: UIdata
                                                          .textSubTitleStyleDark,
                                                    ),
                                                    trailing: Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        color: Colors.black,
                                                        size: 30.0),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          );
                                        } else {
                                          return SizedBox(height: 1);
                                        }
                                      })
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
