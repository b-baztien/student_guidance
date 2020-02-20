import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_guidance/page/Home/news-page.dart';
import 'package:student_guidance/page/Views/list-teacher.dart';
import 'package:student_guidance/page/dashboard/dashboard.dart';
import 'package:student_guidance/page/search-new/Search_widget_new.dart';
import 'package:student_guidance/utils/UIdata.dart';

class Home extends StatefulWidget {
  static String tag = "home-page";

  @override
  _HomeState createState() => _HomeState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _HomeState extends State<Home> {
  int _selectedPage = 0;
  final _pageOptions = [
    NewsPage(),
    SearchWidgetNew(),
    ListTeacher(),
    Dashboard(),
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
          fixedColor: Colors.redAccent,
          currentIndex: _selectedPage,
          items: [
            BottomNavigationBarItem(
                icon: new Icon(FontAwesomeIcons.newspaper, size: 30),
                title: new Text('ข่าว')),
            BottomNavigationBarItem(
                icon: new Icon(FontAwesomeIcons.search, size: 30),
                title: new Text('ค้นหา')),
            BottomNavigationBarItem(
                icon: new Icon(Icons.group, size: 30),
                title: new Text('คุณครู')),
            BottomNavigationBarItem(
                icon: new Icon(FontAwesomeIcons.chartBar, size: 30),
                title: new Text('แผนภูมิ')),
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
