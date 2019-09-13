import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart' as prefix0;
import 'package:student_guidance/page/Edit/EditProfile.dart';
import 'package:student_guidance/page/Views/mapTest.dart';
import 'package:student_guidance/page/Views/view-profile-teacher.dart';
import 'package:student_guidance/page/dashboard/dashboard.dart';
import 'package:student_guidance/page/home/BodyNews.dart';
class Home extends StatefulWidget {
  static String tag = "home-page";

  @override
  _HomeState createState() => _HomeState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  List<String> _locations = ['แม่โจ้', 'เชียงใหม่', 'พะเยา', 'กรุงเทพ'];
  String _selectedLocation = 'เลือก มหาวิทยาลัย';
  int _selectedPage = 0;
  final _pageOptions = [
   BodyNews(),
    ViewTeacher(),
    GoogleMapTest(),
    Dashboard(),
    EditProfile(),
  ];
  
  
  Icon actionIcon = new Icon(Icons.search);
  Icon menuIcon = new Icon(Icons.menu);
 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: new Theme(
    data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
        canvasColor: Colors.white,
        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        primaryColor: Colors.green,
        textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(caption: new TextStyle(color: Colors.grey))), // sets the inactive color of the `BottomNavigationBar`
    child: new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedPage,
     
        items: [
     BottomNavigationBarItem(
       icon: new Icon(Icons.home,size:30),
       title: new Text('Home')
       ),
         BottomNavigationBarItem(
       icon: new Icon(Icons.assignment_ind , size: 30),
       title: new Text('Techer')
       ),
        BottomNavigationBarItem(
       icon: new Icon(Icons.map, size: 30),
       title: new Text('Map')
       ),
        BottomNavigationBarItem(
       icon: new    Icon(Icons.dashboard, size: 30),
       title: new Text('Dashboard')
       ),
        BottomNavigationBarItem(
       icon: new  Icon(Icons.person, size: 30),
       title: new Text('Profile')
       )
    ],
    onTap: (int index){
     setState(() {
       _selectedPage = index;
     });
    },
      ),
    
    ),
    );
    
  }

       

}
