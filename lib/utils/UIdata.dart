import 'package:flutter/material.dart';
import 'package:student_guidance/page/dashboard/dashboard.dart';
import 'package:student_guidance/page/home/home.dart';
import 'package:student_guidance/page/login/login.dart';

class UIdata {
  static List<String> routesName = [LoginPage.tag, Dashboard.tag];

  static Map<String, WidgetBuilder> routes = {
    LoginPage.tag: (context) => LoginPage(),
    Home.tag: (context) => Home(),
    Dashboard.tag: (context) => Dashboard()
  };
}
