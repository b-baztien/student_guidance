import 'package:flutter/material.dart';
import 'package:student_guidance/page/Edit/EditProfile.dart';
import 'package:student_guidance/page/News/view_news.dart';
import 'package:student_guidance/page/Views/view-profile-teacher.dart';
import 'package:student_guidance/page/dashboard/dashboard.dart';
import 'package:student_guidance/page/home/home-drawer.dart';
import 'package:student_guidance/page/home/home.dart';
import 'package:student_guidance/page/login/login.dart';

class UIdata {
  static Icon actionIcon = new Icon(Icons.arrow_back);
  static Icon menuIcon = new Icon(Icons.menu);
  static Icon searchIcon = new Icon(Icons.search);

  static Map<String, WidgetBuilder> routes = {
    LoginPage.tag: (context) => LoginPage(),
    Home.tag: (context) => Home(),
    Dashboard.tag: (context) => Dashboard(),
    News.tag: (context) => News(),
    ViewTeacher.tag: (context) => ViewTeacher(),
    EditProfileStudent.tag: (context) => EditProfileStudent(),
  };

  static String loginPageTag = LoginPage.tag;
  static String homeTag = Home.tag;
  static String dashboardTag = Dashboard.tag;
  static String newsTag = News.tag;
  static String viewTeacherTag = ViewTeacher.tag;
  static String editProfileStudentTag = EditProfileStudent.tag;
}
