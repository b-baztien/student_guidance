import 'package:flutter/material.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/service/LoginService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _username, _password;
  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Form(
        key: _globalKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              validator: (String input) {
                if (input.isEmpty) {
                  return 'กรุณากรอกชื่อผู้ใช้งาน';
                }
              },
              onSaved: (input) => _username = input,
              decoration: InputDecoration(
                  labelText: "ไอดีผู้ใช้", hasFloatingPlaceholder: true),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              obscureText: true,
              validator: (input) {
                if (input.length < 4) {
                  return 'รหัสผ่านต้องประกอบไปด้วย 4 ตัวอักษร';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                  labelText: "รหัสผ่าน", hasFloatingPlaceholder: true),
            ),
            const SizedBox(height: 10.0),
            RaisedButton(
              color: Colors.green.shade700,
              textColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text("เข้าสู่ระบบ"),
              onPressed: signIn,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _globalKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        Login login = new Login();
        login.username = _username;
        login.password = _password;
        await LoginService().login(login);
        await Navigator.pushNamedAndRemoveUntil(
            context, UIdata.homeTag, ModalRoute.withName(UIdata.homeTag));
      } catch (e) {
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);
      }
    }
  }
}