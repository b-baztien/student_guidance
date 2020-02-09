import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/model/School.dart';
import 'package:student_guidance/model/Teacher.dart';
import 'package:student_guidance/service/SchoolService.dart';
import 'package:student_guidance/service/StudentService.dart';
import 'package:student_guidance/service/TeacherService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ListTeacher extends StatefulWidget {
  @override
  _ListTeacherState createState() => _ListTeacherState();
}

class _ListTeacherState extends State<ListTeacher> {
  String shcool_name = '';
  School school = new School();
  List<Teacher> listTeacher = new List<Teacher>();



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
