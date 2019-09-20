import 'package:flutter/material.dart';

import 'SearchFaculty_widget.dart';
import 'SearchMajor_widget.dart';
import 'SearchUniversity_widget.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('สนใจอะไรอยู่',style: TextStyle(color: Colors.orange[200],  fontFamily: 'Kanit', fontSize: 25.0, )),
        backgroundColor: Colors.indigo,
        elevation: 0,
        bottom: TabBar(
          labelColor:Colors.indigo ,
          unselectedLabelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,

          indicator: BoxDecoration(
            
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
            color: Colors.white
          ),
          tabs: <Widget>[
            Tab(
              
              child: Align(
                alignment: Alignment.center,
                child: Row(children: <Widget>[
                  Icon(Icons.account_balance),
                  Text('มหาวิทยาลัย',style: TextStyle(fontFamily: 'Kanit',)),
                ],
                ),
                
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                 child: Row(children: <Widget>[
                  Icon(Icons.import_contacts),
                  Text('กลุ่มคณะ',style: TextStyle(fontFamily: 'Kanit',)),
                ],
                ),
               
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                 child: Row(children: <Widget>[
                  Icon(Icons.event_seat),
                  Text('กลุ่มสาขา',style: TextStyle(fontFamily: 'Kanit',)),
                ],
                ),
                
              ),
            ),
          
          ],
        ),
        ),
        body: TabBarView(
          children: <Widget>[
            SearchUniversityWidget(),
            SearchFaculty(),
            SearchMajor(),
           
          ],
        ),
        ),
      ),
     
    );
  }
}