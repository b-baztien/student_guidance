import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:student_guidance/page/login/login.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: LoginPage(),
        imageBackground: NetworkImage('https://viveconstyle.com/wp-content/uploads/2019/03/Brighter-days-quote-mobile-wallpaper.jpg'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(color: Colors.deepPurple),
        photoSize: 100.0,
        loaderColor: Colors.amberAccent);
  }
}