import 'package:flutter/material.dart';
import 'package:student_guidance/page/Edit/EditProfile.dart';
import 'package:student_guidance/utils/UIdata.dart';

import 'add-education.dart';

class HomeDrawer {
  BuildContext context;

  HomeDrawer(BuildContext context) {
    this.context = context;
  }

  drawer() => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://www.how-to-study.com/images/study-skills-assessments.jpg'))),
              accountName: Text("องอาจ ใจทมิฬ"),
              accountEmail: Text("ashishrawat2911@gmail.com"),
              currentAccountPicture: new GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, EditProfile.tag);
                },
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.white,
                  backgroundImage: NetworkImage(
                      'https://avatarfiles.alphacoders.com/894/89415.jpg'),
                ),
              ),
            ),
            ListTile(
              title: Text('ข้อมูลครูแนะแนว'),
              onTap: () {
                 Navigator.pushNamed(context, UIdata.viewTeacherTag);
              },
            ),
            ListTile(
              title: Text('เพิ่มที่สอบติด'),
              onTap: () {
                showDialog(context: context,
                builder : (context){
                    return MyDialog();
                },
                );
              },
            ),
             ListTile(
              title: Text('Dashboard'),
              onTap: () {
                 Navigator.pushNamed(context, UIdata.viewTeacherTag);
              },
            ),
            ListTile(
              title: Text('_ViewEducation'),
              onTap: () {
                Navigator.pushNamed(context, UIdata.viewEducation);
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
}
