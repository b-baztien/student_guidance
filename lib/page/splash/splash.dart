import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:student_guidance/page/login/landing.dart';

class SplashPage extends StatefulWidget {
   static String tag = 'splash-page';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: Landing(),
        imageBackground: AssetImage('assets/images/background.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(color: Colors.deepPurple),
        photoSize: 100.0,
        loaderColor: Colors.amberAccent);
  }
}