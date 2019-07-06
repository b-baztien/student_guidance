import 'package:flutter/material.dart';
import 'package:student_guidance/page/Edit/EditProfile.dart';

class HomeDrawer {
  drawer(BuildContext context) => Drawer(
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
                  Navigator.pushNamed(context, EditProfileStudent.tag);
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
              title: Text('Setting'),
              onTap: () {
                Navigator.pop(context);
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
