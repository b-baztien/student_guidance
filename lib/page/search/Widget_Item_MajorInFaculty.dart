import 'package:flutter/material.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/SearchService.dart';
import 'package:student_guidance/utils/UIdata.dart';
import 'package:url_launcher/url_launcher.dart';

class MajorInFaculty extends StatefulWidget {
  final University university;
  final String faculty;

  const MajorInFaculty({Key key, this.university, this.faculty})
      : super(key: key);

  @override
  _MajorInFacultyState createState() => _MajorInFacultyState();
}

class _MajorInFacultyState extends State<MajorInFaculty> {
  List<Major> listMajor = new List<Major>();
  Faculty fac = new Faculty();
  String link = "loading...";
  @override
  void initState() {
    super.initState();
    SearchService()
        .getFacultyForSearch(widget.faculty, widget.university.universityname)
        .then((facultyFromService) {
      SearchService()
          .getListMajor(facultyFromService)
          .then((listMajorFromService) {
        setState(() {
          fac = facultyFromService;
          listMajor = listMajorFromService;
          link = fac.url;
          print(fac.url);
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
                fontFamily: 'Kanit',
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
                                fontFamily: 'kanit',
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
                            widget.faculty,
                            style: TextStyle(
                                fontFamily: 'kanit',
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
                top: 100,
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
                top: 110,
                left: 25,
                right: 25,
                child: Container(
                  height: (MediaQuery.of(context).size.height / 2),
                  child: Column(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              Text("เว็บไซต์ : ",
                                  style:
                                      TextStyle(fontSize: 18),),
                              InkWell(
                                child: Text(
                                  link,
                                  style:
                                      TextStyle(fontSize: 18, color: Colors.blue),
                                ),
                                onTap: () => launch(fac.url),
                              ),
                            ],
                          )
                          ),
                      Container(
                      alignment: Alignment.centerLeft,
                        child: Text(
                          "จำนวนศิษย์เก่าที่เรียนที่นี่",
                          style: TextStyle(fontSize: 18, ),
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
                                "สาขาภายในคณะ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Kanit',
                                    fontSize: 15.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: (MediaQuery.of(context).size.height /3),
                        child: ListView.builder(
                          itemCount: listMajor.length,
                          itemBuilder: (_, index) {
                            return ListTile(
                             trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.black, size: 30.0),
                              title: Text(listMajor[index].majorName,
                                  style: TextStyle(
                                      fontFamily: 'Kanit', fontSize: 18.0)),
                                      
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
        ));
  }
}
