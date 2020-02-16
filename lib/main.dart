import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_guidance/page/Splash/splash.dart';

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
      home: SplashPage(),
      routes: UIdata.routes,
    );
  }
}
