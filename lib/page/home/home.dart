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
                      fontSize: 20.0
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
          centerTitle: true ,
           title: Icon(Icons.search,size: 50,),
         backgroundColor: Colors.orangeAccent,
          
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
                MyListItem(Icons.library_music,"music",0xff232223,LoginPage.tag),

              ],
              staggeredTiles: [
                StaggeredTile.extent(2, 130),
                StaggeredTile.extent(2, 130),
                StaggeredTile.extent(2, 130),
                StaggeredTile.extent(2, 130),
                StaggeredTile.extent(2, 130),

              ],
            ),

        ),
         
            
            );
  }
}
