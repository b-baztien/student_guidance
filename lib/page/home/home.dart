import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:student_guidance/page/News/view_news.dart';
import 'package:student_guidance/page/Views/view-profile-teacher.dart';
import 'package:student_guidance/page/dashboard/dashboard.dart';
import 'package:student_guidance/page/login/login.dart';

class Home extends StatefulWidget {
  static String tag = "home-page";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  Material MyListItem(IconData icon,String heading,int color,String contexts){
    return Material(
          
          color: Colors.white,
          elevation: 14.0,
          shadowColor: Color(0x802196F3),
          borderRadius: BorderRadius.circular(24.0),
          child: new Container(
          
              child: FlatButton( color: Colors.white,
                shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                child: Padding( padding: EdgeInsets.all(8.0),
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //text
                      Padding(
                        padding:const EdgeInsets.all(8.0),
                      child:Text(heading,style: TextStyle(color:new Color(color),
                      fontSize: 15.0
                      ),
                      ),
                      ),
                    //icon
                    Material(
                      color: new Color(color),
                      borderRadius: BorderRadius.circular(24.0),
                      child:Padding(
                        padding:const EdgeInsets.all(16.0),
                        child: Icon(icon,
                        color: Colors.white,
                        size: 30.0,
                        ), 
                    )
                    )



                  ],
                  )
                ],
              ),
              
              ), onPressed: () {
                Navigator.pushNamed(context,contexts);
              },
              ),
            
      
              

          ),
    );
  }
  Widget appBarTitle = new Text("What your name ?");
  Icon actionIcon = new Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
        appBar: AppBar(
          
          centerTitle: true,
        title:appBarTitle,
        actions: <Widget>[
          new IconButton(icon: actionIcon,onPressed:(){
          setState(() {
                     if ( this.actionIcon.icon == Icons.search){
                      this.actionIcon = new Icon(Icons.close);
                      this.appBarTitle = new TextField(
                        style: new TextStyle(
                          color: Colors.white,

                        ),
                        decoration: new InputDecoration(
                          prefixIcon: new Icon(Icons.search,color: Colors.white),
                          hintText: "ค้นหา มหาวิทยาลัย/คณะ/สาขา",
                          hintStyle: new TextStyle(color: Colors.white)
                        ),
                      );}
                      else {
                        this.actionIcon = new Icon(Icons.search);
                        this.appBarTitle = new Text("What your name ?");
                      }


                    });
        } ,),]
          ),
            body: StaggeredGridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
              children: <Widget>[
                MyListItem(Icons.account_balance,"มหาลัยที่แนะนำ",0xffff9100,Home.tag),
                MyListItem(Icons.supervisor_account,"ข้อมูลครูแนะแนว",0xff81d4fa,ViewTeacher.tag),
                MyListItem(Icons.library_add,"เพิ่มที่สอบติด",0xff232223,Dashboard.tag),
                MyListItem(Icons.assignment,"รายการข่าวสาร",0xff651fff,News.tag),
                MyListItem(Icons.edit,"แก้ไขข้อมูล",0xff66bb6a,News.tag),
                MyListItem(Icons.library_music,"Dashboard",0xff232223,Dashboard.tag),

              ],
              staggeredTiles: [
                StaggeredTile.extent(2, 130),
                StaggeredTile.extent(1, 150),
                StaggeredTile.extent(1, 150),
                StaggeredTile.extent(1, 150),
                StaggeredTile.extent(1, 150),
                StaggeredTile.extent(4, 220),

              ],
            ),

        ),
         
            
            );
  }
}
