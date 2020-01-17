import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_guidance/page/home/home.dart';
import 'package:student_guidance/page/login/login-new.dart';
import 'package:student_guidance/page/splash/splash.dart';
import 'package:student_guidance/page/tutorials/View_Tutorial.dart';

import 'package:student_guidance/utils/UIdata.dart';

import 'package:intl/date_symbol_data_local.dart';

void main() => initializeDateFormatting("th_TH").then((_) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Guidance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: UIdata.fontFamily,
        primarySwatch: UIdata.themeMaterialColor,
      ),
      home: Home(),
      routes: UIdata.routes,
    );
  }
}