import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/service/LoginService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    super.initState();
    _loadFirstTimeAppOpen();
  }

  _loadFirstTimeAppOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');
    if (firstTime != null && !firstTime) {
      // Not first time
      _loadUserInfo();
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, UIdata.tutorialTag, ModalRoute.withName(UIdata.tutorialTag));
    }
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.get('login') != null) {
        LoginService().login(Login.fromJson(jsonDecode(prefs.get('login'))));
        Navigator.pushNamedAndRemoveUntil(
            context, UIdata.homeTag, ModalRoute.withName(UIdata.homeTag));
      } else {
        throw Exception;
      }
    } catch (error) {
      Navigator.pushNamedAndRemoveUntil(context, UIdata.loginPageTag,
          ModalRoute.withName(UIdata.loginPageTag));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
