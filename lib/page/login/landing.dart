import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/SharedPreferences/SharedPref.dart';
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
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.get('login') == null) {
        LoginService().login(Login.fromJson(jsonDecode(prefs.get('login'))));
        Navigator.pushNamedAndRemoveUntil(
            context, UIdata.loginPageTag, ModalRoute.withName(UIdata.loginPageTag));
      } else {
        throw Exception;
      }
    } catch (error) {
      Navigator.pushNamedAndRemoveUntil(
          context, UIdata.homeTag, ModalRoute.withName(UIdata.homeTag));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
