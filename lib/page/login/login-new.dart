import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/StudentRecommend.dart';
import 'package:student_guidance/page/Login/login_form.dart';
import 'package:student_guidance/page/Login/signup_form.dart';
import 'package:student_guidance/service/StudentReccommendService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class LoginPages extends StatefulWidget {
  static String tag = 'login-page-new';

  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  bool formVisible;
  int _formsIndex;
  bool _isLoadlogin = false;
  callback(newFormVisible) {
    setState(() {
      formVisible = newFormVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    formVisible = false;
    _formsIndex = 1;

    login(context);
  }

  login(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.get('login') != null) {
        setState(() {
          _isLoadlogin = true;
        });

        if (jsonDecode(prefs.get('login'))['type'] == 'student') {
          StudentRecommend _stdRec =
              await StudentRecommendService().getStudentRecommendByUsername();
          if (_stdRec == null) {
            await Navigator.of(context).pushNamedAndRemoveUntil(
                UIdata.addRecommendCareerTag,
                ModalRoute.withName(
                  UIdata.addRecommendCareerTag,
                ),
                arguments: UIdata.homeTag);
          }
        }
        Navigator.of(context).pushNamedAndRemoveUntil(
            UIdata.homeTag, ModalRoute.withName(UIdata.homeTag));
      }
    } catch (error) {
      throw (error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/login-1.jpg'),
              fit: BoxFit.cover,
            )),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                'ล็อคอิน',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text(
                'Student Guidance',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'kanit',
                  fontWeight: FontWeight.w500,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 100, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _isLoadlogin
                    ? <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'กำลังเข้าสู่ระบบ',
                          style: UIdata.textTitleStyle,
                        ),
                      ]
                    : <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Colors.blueAccent,
                            textColor: Colors.white,
                            child: Text("ลงชื่อเข้าใข้"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              setState(() {
                                formVisible = true;
                                _formsIndex = 1;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                child: child,
                scale: animation,
              );
            },
            child: (!formVisible)
                ? null
                : Container(
                    color: Colors.black54,
                    alignment: Alignment.center,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return ScaleTransition(
                                    child: child,
                                    scale: animation,
                                  );
                                },
                                child: _formsIndex == 1
                                    ? LoginForm(callback)
                                    : SignupForm(),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    ));
  }
}
