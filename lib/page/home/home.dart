import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_guidance/page/Views/view-profile-student.dart';
import 'package:student_guidance/page/add_data/add_education.dart';
import 'package:student_guidance/page/dashboard/dashboard.dart';
import 'package:student_guidance/page/home/BodyNews.dart';
import 'package:student_guidance/page/search/Search_widget.dart';
import 'package:student_guidance/utils/UIdata.dart';

class Home extends StatefulWidget {
  static String tag = "home-page";

  @override
  _HomeState createState() => _HomeState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  int _selectedPage = 0;
  final _pageOptions = [
    BodyNews(),
    SearchWidget(),
    AddEducation(),
    Dashboard(),
    ViewProfile(),
  ];

  Icon actionIcon = new Icon(Icons.search);
  Icon menuIcon = new Icon(Icons.menu);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIdata.themeColor,
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.white,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: UIdata.themeColor,
            textTheme: Theme.of(context).textTheme.copyWith(
                caption: new TextStyle(
                    color: Colors
                        .grey))), // sets the inactive color of the `BottomNavigationBar`
        child: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedPage,
          items: [
            BottomNavigationBarItem(
                icon: new Icon(Icons.home, size: 30),
                title: new Text('หน้าแรก')),
            BottomNavigationBarItem(
                icon: new Icon(Icons.search, size: 30),
                title: new Text('ค้นหา')),
            BottomNavigationBarItem(
                icon: new Icon(Icons.map, size: 30),
                title: new Text('Education')),
            BottomNavigationBarItem(
                icon: new Icon(Icons.dashboard, size: 30),
                title: new Text('Dashboard')),
            BottomNavigationBarItem(
                icon: new Icon(Icons.person, size: 30),
                title: new Text('Profiles'))
          ],
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
        ),
      ),
    );
  }
}
