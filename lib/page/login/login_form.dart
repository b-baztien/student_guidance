import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
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
    ProgressDialog _progressDialog =
        new ProgressDialog(context, type: ProgressDialogType.Normal);
    _progressDialog.style(message: 'กำลังโหลด...');

    Future<void> signIn() async {
      final formState = _globalKey.currentState;
      print(formState.validate());
      if (formState.validate()) {
        formState.save();
        try {
          Login login = new Login();
          login.username = _username.trim();
          login.password = _password;
          _progressDialog.show();
          await LoginService().login(login);
          await Navigator.pushNamedAndRemoveUntil(
              context, UIdata.homeTag, ModalRoute.withName(UIdata.homeTag));
        } catch (e) {
          _progressDialog.hide();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                e.toString(),
                style: TextStyle(fontFamily: UIdata.fontFamily),
              ),
            ),
          );
        }
      }
    }

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
                return null;
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
                return null;
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
}
