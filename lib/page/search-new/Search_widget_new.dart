

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/page/drawer/Mydrawer.dart';
import 'package:student_guidance/utils/UIdata.dart';

class SearchWidgetNew extends StatefulWidget {
  @override
  _SearchWidgetNewState createState() => _SearchWidgetNewState();
}

class _SearchWidgetNewState extends State<SearchWidgetNew> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: _getPrefs(),
        builder: (context,snapshot){
          if(snapshot.hasData){
          return MaterialApp(
            title: 'Search Page',
            debugShowCheckedModeBanner: false,
            home: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/thembg.png"),
                    fit: BoxFit.fill
                )
              ),
              child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Text(UIdata.tx_search_widget,style: UIdata.textTitleStyle,),
              ),
              drawer: MyDrawer(student:
              Student.fromJson(
                  jsonDecode(snapshot.data.getString('student'))),
                  schoolId:snapshot.data.getString('schoolId')),
            ),
            ),

          );
          }else{
            return Scaffold();
          }
        },
      ),

    );



  }

  Future<SharedPreferences> _getPrefs() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs;
  }
}
