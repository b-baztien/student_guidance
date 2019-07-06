import 'package:flutter/material.dart';
import 'package:student_guidance/page/home/home.dart';

class EditProfileStudent extends StatefulWidget {
  static String tag = 'EditProfileStudent';
  @override
  _EditProfileStudentState createState() => _EditProfileStudentState();
}

class _EditProfileStudentState extends State<EditProfileStudent> {
  Icon actionIcon = new Icon(Icons.arrow_back);
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text('แก้ไขข้อมูลส่วนตัว'),
          leading:
            new IconButton(icon: actionIcon,onPressed: (){
               Navigator.pushNamed(context,Home.tag);
            },),
      ),
      ),
    );
  }
}