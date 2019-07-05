import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_guidance/page/dashboard/dashboard.dart';
import 'package:student_guidance/page/home/home.dart';
import 'package:student_guidance/page/login/login.dart';
import 'package:student_guidance/utils/UIdata.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget{
  
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Student Guidance',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Kanit'),
        home: LoginPage(),
        routes: UIdata.routes,
        );
  }

}