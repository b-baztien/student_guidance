import 'package:flutter/material.dart';
import 'package:student_guidance/model/Carrer.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/FacultyService.dart';
import 'package:student_guidance/service/SearchService.dart';
import 'package:student_guidance/utils/UIdata.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetItemMajor extends StatefulWidget {
  
  final University university;
  final String majorName;
  const WidgetItemMajor({Key key, this.university, this.majorName})
      : super(key: key);

  @override
  _WidgetItemMajorState createState() => _WidgetItemMajorState();
}

class _WidgetItemMajorState extends State<WidgetItemMajor> {
  Major major = new Major();
  String facName = "loading...";
  String majorDetail = "loading...";
  String url = "loading...";

  List<Carrer> listCarrer = new List<Carrer>();
  @override
  void initState() {
    super.initState();
    SearchService()
        .getMajorForSearch(widget.majorName, widget.university.universityname)
        .then((majorFromService) {
      FacultyService()
          .getFaculty(majorFromService.faculty)
          .then((facultyFromService) {
        SearchService()
            .getListCarrer(majorFromService.carrer)
            .then((carrerFromService) {
          setState(() {
            listCarrer = carrerFromService;
            majorDetail = majorFromService.entrancedetail;
            url = majorFromService.url;
            facName = facultyFromService.facultyName;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIdata.themeColor,
      appBar: AppBar(
        title: Text('รายละเอียด',
            style: TextStyle(
              fontFamily: UIdata.fontFamily,
              fontSize: 20,
            )),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.university.universityname,
                          style: TextStyle(
                              fontFamily: UIdata.fontFamily,
                              color: Colors.white,
                              fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "คณะ " + facName,
                          style: TextStyle(
                              fontFamily: UIdata.fontFamily,
                              color: Colors.white,
                              fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "สาขา " + widget.majorName,
                          style: TextStyle(
                              fontFamily: UIdata.fontFamily,
                              color: Colors.white,
                              fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 130,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height - 100,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
              top: 165,
              left: 25,
              right: 25,
              height: MediaQuery.of(context).size.height - 300,
              child: Container(
                height: (MediaQuery.of(context).size.height / 2),
                child: ListView(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "รายละเอียดสาขา",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        majorDetail,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "เว็บไซต์ : ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          InkWell(
                            child: Text(
                              url,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.blue),
                            ),
                            onTap: url == "-" ? () {} : () => launch(url),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          color: UIdata.themeColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 6.0),
                            child: Text(
                              "สาขาอาชีพที่เกี่ยวข้อง",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: UIdata.fontFamily,
                                  fontSize: 15.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        itemCount: listCarrer.length,
                        itemBuilder: (_, index) {
                          return Container(
                            alignment: Alignment.center,
                            child: Text(
                              listCarrer[index].carrer_name,
                              style: TextStyle(
                                  fontFamily: UIdata.fontFamily,
                                  fontSize: 16.0),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
