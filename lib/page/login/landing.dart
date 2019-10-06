import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/SharedPreferences/SharedPref.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/utils/UIdata.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String _username = "";
   @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

   _loadUserInfo() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    _username = (prefs.getString('username') ?? "");
  
    if (_username == "") {
      Navigator.pushNamedAndRemoveUntil(
          context, UIdata.splashPage, ModalRoute.withName(UIdata.splashPage));
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, UIdata.homeTag, ModalRoute.withName(UIdata.homeTag));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}