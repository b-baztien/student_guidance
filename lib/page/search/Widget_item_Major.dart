import 'package:flutter/material.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/FacultyService.dart';
import 'package:student_guidance/service/SearchService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class WidgetItemMajor extends StatefulWidget {
  final University university;
  final String majorName;

  const WidgetItemMajor({Key key, this.university, this.majorName}) : super(key: key);
  @override
  _WidgetItemMajorState createState() => _WidgetItemMajorState();
}

class _WidgetItemMajorState extends State<WidgetItemMajor> {
  Faculty fac = new Faculty();
  Major major = new Major();
   @override
  void initState() {
    super.initState();
   SearchService().getMajorForSearch(widget.majorName,widget.university.universityname).then((majorFromService){
     FacultyService().getFaculty(majorFromService.faculty).then((facultyFromService){
       setState(() {
         major = majorFromService;
        fac =  facultyFromService;
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
                            widget.majorName,
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
            ],
          ),
        ),
      
    );
  }
}