import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/RecommendMajor.dart';
import 'package:student_guidance/page/search-new/itemMajor-new.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/service/MajorService.dart';
import 'package:student_guidance/service/StudentFavoriteService.dart';
import 'package:student_guidance/service/StudentReccommendService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ListRecommend extends StatefulWidget {
  final Login login;

  const ListRecommend({
    Key key,
    this.login,
  }) : super(key: key);

  @override
  _ListRecommendState createState() => _ListRecommendState();
}

class _ListRecommendState extends State<ListRecommend> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProgressDialog _progressDialog;

  @override
  void initState() {
    super.initState();
    _progressDialog =
        UIdata.buildLoadingProgressDialog(context, 'กำลังโหลด...');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Color(0xff003471)])),
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 8, left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'แนะนำสาขา ตามอาชีพที่สนใจ',
                          style: UIdata.textTitleStyle24,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      itemRecommend(),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemRecommend() {
    return FutureBuilder(
      future: StudentRecommendService().getRecommendMajor(),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<RecommendMajor> list = snapshot.data;
          return Column(
            children: list.isNotEmpty
                ? list
                    .map(
                      (recommendMajor) => Padding(
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
                              onTap: () async {
                                setState(() {
                                  _progressDialog.show();
                                });
                                await StudentFavoriteService()
                                    .getStudentFavoriteByUsername(
                                        widget.login.username)
                                    .then((listFavorite) async {
                                  DocumentSnapshot majorDoc =
                                      await MajorService().getMajor(
                                          recommendMajor.university,
                                          recommendMajor.faculty,
                                          recommendMajor.major);

                                  setState(() {
                                    _progressDialog.hide();
                                  });

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ItemMajorNew(
                                        universityName:
                                            recommendMajor.university,
                                        facultyName: recommendMajor.faculty,
                                        major: majorDoc,
                                        listFavorite: listFavorite,
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: EdgeInsets.only(right: 10.0),
                                          decoration: new BoxDecoration(
                                            border: new Border(
                                              right: new BorderSide(
                                                  width: 2.0,
                                                  color: Color(0xff005BC7)),
                                            ),
                                          ),
                                          child: FutureBuilder<String>(
                                            future: GetImageService()
                                                .getImage(recommendMajor.img),
                                            initialData: null,
                                            builder: (context, snapshot) {
                                              return Container(
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
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Flex(
                                            direction: Axis.vertical,
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                child: AutoSizeText(
                                                  recommendMajor.university,
                                                  style: TextStyle(
                                                      fontFamily: 'Kanit',
                                                      color: Color(0xff005BC7)),
                                                  softWrap: true,
                                                  minFontSize: 18,
                                                  maxFontSize: 20,
                                                ),
                                              ),
                                              Expanded(
                                                child: Flex(
                                                  direction: Axis.horizontal,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 3,
                                                      child: Icon(
                                                        Icons.school,
                                                        color:
                                                            Color(0xff005BC7),
                                                        size: 22,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 20,
                                                      child: AutoSizeText(
                                                        recommendMajor.faculty,
                                                        minFontSize: 15,
                                                        style: TextStyle(
                                                          fontFamily: 'Kanit',
                                                          color:
                                                              Color(0xff005BC7),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Flex(
                                                  direction: Axis.horizontal,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 3,
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .userGraduate,
                                                        color:
                                                            Color(0xff005BC7),
                                                        size: 18,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 20,
                                                      child: AutoSizeText(
                                                        recommendMajor.major,
                                                        minFontSize: 14,
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList()
                : Padding(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/uni-not-found.png',
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text('ไม่พบข้อมูลที่ตรงกัน !'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        } else {
          return Column(
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
          );
        }
      },
    );
  }
}
