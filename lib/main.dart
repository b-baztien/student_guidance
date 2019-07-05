import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_guidance/page/dashboard/dashboard.dart';
import 'package:student_guidance/page/home/home.dart';
import 'package:student_guidance/page/login/login.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget{
  final routes = <String, WidgetBuilder>{
    LoginPage.tag:(context) =>LoginPage(),
     Home.tag:(context) =>Home(),
     Dashboard.tag : (context) => Dashboard()
  };
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Student Guidance',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Kanit'),
        home: LoginPage(),
        routes: routes,
        );
  }

}