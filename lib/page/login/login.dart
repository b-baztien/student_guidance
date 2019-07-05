import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  static String tag = 'login-page';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Student Guidance',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Kanit'),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: loginBody(),
          ),
        ));
  }

  loginBody() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[loginHeader(), loginFields()],
        ),
      );

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

  loginFields() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'กรุณากรอกชื่อผู้ใช้',
                  labelText: 'ชื่อผู้ใช้',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextField(
                maxLines: 1,
                obscureText: true,
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
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {},
              child: Column(children: [
                Text('มีปัญหาในการเข้าสู่ระบบ ?',
                    style: TextStyle(color: Colors.grey)),
              ]),
            ),
          ],
        ),
      );
}
