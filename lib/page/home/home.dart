import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart' as prefix0;
import 'package:student_guidance/page/Edit/EditProfile.dart';
import 'package:student_guidance/page/Views/mapTest.dart';
import 'package:student_guidance/page/Views/view-education-detail.dart';
import 'package:student_guidance/page/Views/view-profile-teacher.dart';
import 'package:student_guidance/page/dashboard/dashboard.dart';
import 'package:student_guidance/widgets/customCard.dart';
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
  int _selectedPage = 0;
  Home home;
  GoogleMapTest map;
  ViewTeacher techer;
  Dashboard dash;
  EditProfile profile;

   

  GlobalKey _bottomNavigationKey = GlobalKey();
  
  Icon actionIcon = new Icon(Icons.search);
  Icon menuIcon = new Icon(Icons.menu);
 

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

    Widget  header(){
    return new Container(
        height: 140.0,       
         width: MediaQuery.of(context).size.width,        
        color: Colors.green,        
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 60.0),        
               Text('Student Guidance',     
                        style: TextStyle(
            color: Colors.white,          
                    fontSize: 25.0,          
                        fontWeight: FontWeight.bold              ),),          ],        )
    );  
    }

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: new Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              header(),
              Column(children: <Widget>[
                 SizedBox(height: 110.0,), 
                 Padding(padding: EdgeInsets.only(left: 12.0, right: 12.0),
                 child: Material(
                   elevation: 5.0,
                   borderRadius: BorderRadius.circular(10.0),
                   child: TextField(
                   
                    onTap: (){
                      showSearch(context: context,delegate: Datasearch());
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search,color: Colors.green,size: 25.0,),
                      contentPadding: EdgeInsets.only(left: 10.0,top: 12.0),
                      hintText: 'มหาวิทยาลัย, คณะ, สาขา',hintStyle: TextStyle(color: Colors.grey)
                      
                    ),
                   ),
                   
                   
                 ),
                 
                 )
              ],)
            ],
          ),
         
          new Expanded(
            
            child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('News')
              .snapshots(),
            builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                          News newsFirebase = new  News();
                          newsFirebase.topic = document['topic'];
                          newsFirebase.detail = document['detail'];
                          return new CustomCard(
                            news:newsFirebase,
                          );
                      }).toList(),
                    );
                }
              },
            ),
          )
        ],
      ),
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
    
   return Center(
        child: Text(
          '"$query"\n ไม่พบข้อมูลที่ค้นหา.\nลองค้นหาด้วยคำอื่น',
          textAlign: TextAlign.center,
        ),
      );
    

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
