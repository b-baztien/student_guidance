import 'package:flutter/material.dart';
import 'package:student_guidance/page/News/view_news.dart';
import 'package:student_guidance/page/Views/view-profile-teacher.dart';
import 'package:student_guidance/page/dashboard/dashboard.dart';
import 'package:student_guidance/page/home/home.dart';
import 'package:student_guidance/page/login/login.dart';

class UIdata {
 

  static Map<String, WidgetBuilder> routes = {
    LoginPage.tag: (context) => LoginPage(),
    Home.tag: (context) => Home(),
    Dashboard.tag: (context) => Dashboard(),
    News.tag : (context) => News(),
    ViewTeacher.tag :(context) => ViewTeacher(),
  };
}
