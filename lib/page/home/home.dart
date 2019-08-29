import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_guidance/page/Views/view-education-detail.dart';
import 'package:student_guidance/widgets/education_widget.dart';
import 'package:student_guidance/page/home/home-drawer.dart';
import 'package:student_guidance/model/News.dart';
import 'package:student_guidance/styleguide.dart';
import 'dart:math';

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
  List<String> _locations = ['แม่โจ้', 'เชียงใหม่', 'พะเยา', 'กรุงเทพ'];
  String _selectedLocation = 'เลือก มหาวิทยาลัย';

  
  Icon actionIcon = new Icon(Icons.search);
  Icon menuIcon = new Icon(Icons.menu);
  var currentPage = images.length - 1.0;

  @override
  Widget build(BuildContext context) {
    
    AppBar homeAppbar() {
      return AppBar(
        centerTitle: true,
        title: Text("ค้นหาอะไรสักอย่าง?"),
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
          showSearch(context: context,delegate: Datasearch());
            },
          ),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFF1b1e44),
              Color(0xFF2d3447),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            tileMode: TileMode.clamp),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: HomeDrawer(context).drawer(),
        appBar: homeAppbar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[

            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.cake),
              title: Text("HOME")
              
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cake),
              title: Text("CAKE")
            )
          ],
        ),
      ),
    );
    
  }

}

class Datasearch extends SearchDelegate<String>{
  final university = [
    "มหาวิทยาลัยน่าน",
    "มหาวิทยาลัยแพร่",
    "มหาวิทยาลัยแม่ฮ่องสอน",
    "มหาวิทยาลัยสุราษฎร์ธานี",
  "มหาวิทยาลัยสุรินทร์",
  "มหาวิทยาลัยหนองคาย"
  ];
  final recentUniversity =[
  "มหาวิทยาลัยแม่ฮ่องสอน",
  "มหาวิทยาลัยสุราษฎร์ธานี",
  "มหาวิทยาลัยสุรินทร์",
  "มหาวิทยาลัยหนองคาย"
  ];


  @override
  List<Widget> buildActions(BuildContext context) {
    //action appbar
    return [IconButton(icon: Icon(Icons.clear),
    onPressed: (){
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
    ?recentUniversity
    :university.where((p) => p.toLowerCase().contains(query)).toList();
    return ListView.builder(
        itemBuilder: (context,index) => ListTile(
          onTap: (){
            query = suggestionList[index];
          var route = new MaterialPageRoute(
            builder: (BuildContext context) => new ViewEducation(value : query),
          );
          Navigator.of(context).push(route);
          },
          leading: new Tab(icon: new Image.asset("assets/images/icon1.png")),
          title: Text(suggestionList[index]
           
          ),
        ),
    itemCount: suggestionList.length,
    );

  }

}
