import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Form(
        key: key,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: "ชื่อ", hasFloatingPlaceholder: true),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "นามสกุล", hasFloatingPlaceholder: true),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "อีเมล", hasFloatingPlaceholder: true),
            ),
            const SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(
                  labelText: "ไอดีผู้ใช้", hasFloatingPlaceholder: true),
            ),
            const SizedBox(height: 10.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "รหัสผ่าน", hasFloatingPlaceholder: true),
            ),
            const SizedBox(height: 10.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "ยืนยันรหัสผ่าน", hasFloatingPlaceholder: true),
            ),
            const SizedBox(height: 10.0),
            RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text("ลงทะเบียน"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
