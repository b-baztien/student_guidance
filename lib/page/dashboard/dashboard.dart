import 'package:flutter/material.dart';
import 'package:student_guidance/page/home/home.dart';

class Dashboard extends StatefulWidget {
  static String tag = "dashboard-page";
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
Icon actionIcon = new Icon(Icons.arrow_back);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text('ข้อมูลเชิงสถิติ'),
          leading:
            new IconButton(icon: actionIcon,onPressed: (){
               Navigator.pushNamed(context,Home.tag);
            },),

        
            
                  
      
       
      ),
      ),
    );
  }
}