import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_guidance/page/login/login.dart';
import 'package:student_guidance/utils/UIdata.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Guidance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Kanit',
        primaryColor: Colors.white,
        appBarTheme: AppBarTheme(elevation: 0, color: Colors.white),
      ),
      home: LoginPage(),
      routes: UIdata.routes,
    );
  }
}