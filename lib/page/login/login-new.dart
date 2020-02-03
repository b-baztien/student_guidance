import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/page/Login/login_form.dart';
import 'package:student_guidance/page/Login/signup_form.dart';
import 'package:student_guidance/utils/UIdata.dart';

class LoginPages extends StatefulWidget {
  static String tag = 'login-page-new';

  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  bool formVisible;
  int _formsIndex;
  @override
  void initState() {
    super.initState();
    formVisible = false;
    _formsIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    login();
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
                children: <Widget>[
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
                  Expanded(
                    child: RaisedButton(
                      color: Colors.grey.shade700,
                      textColor: Colors.white,
                      child: Text("สมัครสมาชิก"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        setState(() {
                          formVisible = true;
                          _formsIndex = 2;
                        });
                        print("22");
                      },
                    ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(
                                  color: _formsIndex == 1
                                      ? Colors.orange.shade700
                                      : Colors.white,
                                  textColor: _formsIndex == 1
                                      ? Colors.white
                                      : Colors.black,
                                  child: Text("ลงชื่อเข้าใช้"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {
                                    setState(() {
                                      _formsIndex = 1;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                RaisedButton(
                                  color: _formsIndex == 2
                                      ? Colors.orange.shade700
                                      : Colors.white,
                                  textColor: _formsIndex == 2
                                      ? Colors.white
                                      : Colors.black,
                                  child: Text("สมัครสมาชิก"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {
                                    setState(() {
                                      _formsIndex = 2;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      formVisible = false;
                                    });
                                  },
                                )
                              ],
                            ),
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
                                    ? LoginForm()
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
}