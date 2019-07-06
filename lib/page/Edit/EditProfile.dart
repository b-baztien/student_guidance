import 'package:flutter/material.dart';
import 'package:student_guidance/utils/UIdata.dart';

class EditProfileStudent extends StatefulWidget {
  static String tag = 'EditProfileStudent';
  @override
  _EditProfileStudentState createState() => _EditProfileStudentState();
}

class _EditProfileStudentState extends State<EditProfileStudent> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text('แก้ไขข้อมูลส่วนตัว'),
          leading: new IconButton(
            icon: UIdata.actionIcon,
            onPressed: () {
              Navigator.pushNamed(context, UIdata.homeTag);
            },
          ),
        ),
      ),
    );
  }
}
