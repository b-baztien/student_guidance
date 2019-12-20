import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/News.dart';
import 'package:student_guidance/model/School.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/model/Teacher.dart';

import 'package:student_guidance/service/NewsService.dart';
import 'package:student_guidance/service/SchoolService.dart';
import 'package:student_guidance/service/StudentService.dart';
import 'package:student_guidance/service/TeacherService.dart';
import 'package:student_guidance/utils/UIdata.dart';

import 'package:student_guidance/widgets/customCard.dart';

class BodyNews extends StatefulWidget {
  @override
  _BodyNewsState createState() => _BodyNewsState();
}

class _BodyNewsState extends State<BodyNews> {
  NewsService newsService = new NewsService();
  Student student = new Student();
  Login login;
  School school = new School();
  String shcool_name = '';
  @override
  void initState() {
    super.initState();
    StudentService().getStudent().then((studentFromService) {
      SchoolService()
          .getSchool(studentFromService.school)
          .then((schoolFromService) {
        setState(() {
          shcool_name = schoolFromService.schoolName;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          backgroundColor: UIdata.themeColor,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: <Widget>[
                  Text(
                    'Student Guidance',
                    style: TextStyle(
                        color: UIdata.fontColor,
                        fontFamily: UIdata.fontFamily,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    shcool_name,
                    style: TextStyle(
                        color: UIdata.fontColor,
                        fontFamily: UIdata.fontFamily,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: UIdata.themeColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
                      child: Text("ข่าวสาร",
                          style: TextStyle(
                              color: UIdata.fontColor,
                              fontFamily: UIdata.fontFamily,
                              fontSize: 20.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 275.0,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: newsService.getNewsList(),
                builder: (_, snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Container(
                          width: 100.0,
                          child: FlareActor(
                            "assets/animates/voters_load.flr",
                            animation: 'Blobs',
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                          ));
                    default:
                      return new ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          News newsFirebase = new News();
                          newsFirebase.topic = snapshot.data[index].topic;
                          newsFirebase.detail = snapshot.data[index].detail;
                          newsFirebase.image = snapshot.data[index].image;
                          newsFirebase.startTime =
                              snapshot.data[index].startTime;
                          newsFirebase.teacher = snapshot.data[index].teacher;

                          DocumentReference test = snapshot.data[index].teacher;
                          Future<Teacher> teacher =
                              TeacherService().getTeacher(test);
                          Teacher teacherPostnews = new Teacher();
                          teacher.then((data) {
                            teacherPostnews.firstname = data.firstname;
                            teacherPostnews.lastname = data.lastname;
                          });
                          return new CustomCard(
                              news: newsFirebase, teachers: teacherPostnews);
                        },
                        scrollDirection: Axis.horizontal,
                      );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
