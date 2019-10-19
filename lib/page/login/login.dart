import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/SharedPreferences/SharedPref.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/page/home/home.dart';
import 'package:student_guidance/service/EntranService.dart';
import 'package:student_guidance/service/LoginService.dart';
import 'package:student_guidance/utils/UIdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/widgets/Dialogs.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _username, _password;
  Dialogs dialogs = new Dialogs();
  loginHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterLogo(
            colors: Colors.blue,
            size: 80.0,
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            'ระบบจัดการแนะแนวสำหรับนักเรียนมัธยมปลาย',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.blue),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'ลงชื่อเข้าใช้งาน',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );

  loginFields() => Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: TextFormField(
                maxLines: 1,
                validator: (String input) {
                  if (input.isEmpty) {
                    return 'กรุณากรอกชื่อผู้ใช้งาน';
                  }
                  return '';
                },
                onSaved: (input) => _username = input,
                decoration: InputDecoration(
                  hintText: 'กรุณากรอกชื่อผู้ใช้',
                  labelText: 'ชื่อผู้ใช้',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextFormField(
                maxLines: 1,
                obscureText: true,
                validator: (input) {
                  if (input.length < 4) {
                    return 'Your password needs to be atleast 6 characters ';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  hintText: 'กรุณากรอกรหัสผ่าน',
                  labelText: 'รหัสผ่าน',
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(15.0),
                shape: StadiumBorder(),
                child: Text(
                  'ลงชื่อเข้าใช้',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: signIn,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () => {},
              child: Column(children: [
                Text('มีปัญหาในการเข้าสู่ระบบ ?',
                    style: TextStyle(color: Colors.grey)),
              ]),
            ),
          ],
        ),
      );

  loginBody() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[loginHeader(), loginFields()],
        ),
      );

  @override
  Widget build(BuildContext context) {
    login();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: loginBody()),
    );
  }

  login() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.get('login') != null) {
        await Navigator.pushNamedAndRemoveUntil(
            context, UIdata.homeTag, ModalRoute.withName(UIdata.homeTag));
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<void> signIn() async {
    final formState = _globalKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        Login login = Login();
        login.username = _username;
        login.password = _password;
        login = await LoginService().login(login);
        await Future.delayed(Duration(seconds: 2));
        await Navigator.pushNamedAndRemoveUntil(
            context, UIdata.homeTag, ModalRoute.withName(UIdata.homeTag));
      } catch (e) {
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);
      }
    }
  }
}
