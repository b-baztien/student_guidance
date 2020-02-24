import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/School.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/model/Teacher.dart';
import 'package:student_guidance/page/Views/item-teacher.dart';
import 'package:student_guidance/page/drawer/Mydrawer.dart';
import 'package:student_guidance/service/TeacherService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ListTeacher extends StatefulWidget {
  @override
  _ListTeacherState createState() => _ListTeacherState();
}

class _ListTeacherState extends State<ListTeacher>
    with TickerProviderStateMixin {
  String shcoolName = '';
  School school = new School();
  List<Teacher> listTeacher = new List<Teacher>();
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/thembg.png"),
                  fit: BoxFit.fill)),
          child: FutureBuilder(
              future: _getPrefs(),
              builder: (context, futureSnapshot) {
                if (futureSnapshot.hasData) {
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      title: Text(
                        UIdata.txTeacherWidget,
                        style: UIdata.textTitleStyle,
                      ),
                    ),
                    drawer: MyDrawer(
                        student: Student.fromJson(jsonDecode(
                            futureSnapshot.data.getString('student'))),
                        login: Login.fromJson(
                            jsonDecode(futureSnapshot.data.getString('login'))),
                        schoolId: futureSnapshot.data.getString('schoolId')),
                    body: StreamBuilder(
                        stream: TeacherService().getAllMapTeacherBySchoolName(
                            futureSnapshot.data.getString('schoolId')),
                        builder: (context, snap) {
                          Map<String, List<Teacher>> map = snap.data;
                          if (snap.hasData) {
                            return SingleChildScrollView(
                              child: Column(
                                children: map.keys.toList().map((key) {
                                  return ItemTeacher(
                                      position: key, listTeacher: map[key]);
                                }).toList(),
                              ),
                            );
                          } else {
                            return SizedBox(height: 1);
                          }
                        }),
                  );
                } else {
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      title: Text(
                        UIdata.txTeacherWidget,
                        style: UIdata.textTitleStyle,
                      ),
                    ),
                    drawer: MyDrawer(),
                  );
                }
              })),
    );
  }

  Future<SharedPreferences> _getPrefs() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs;
  }
}
