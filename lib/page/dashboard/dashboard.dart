import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/page/drawer/Mydrawer.dart';
import 'package:student_guidance/utils/UIdata.dart';

class Dashboard extends StatefulWidget {
  static String tag = "dashboard-page";
  @override
  _DashboardState createState() => _DashboardState();
}


class _DashboardState extends State<Dashboard> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: _getPrefs(),
          builder: (context, futureSnapshot){
            if (futureSnapshot.hasData) {
              return  Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text(UIdata.tx_dashboard_widget,style: UIdata.textTitleStyle,),
                ),
                drawer: MyDrawer(
                    student:
                    Student.fromJson(
                        jsonDecode(futureSnapshot.data.getString('student'))),
                    schoolId:futureSnapshot.data.getString('schoolId')
                ),
                body: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Text(UIdata.tx_dashboard_title,style: UIdata.textSubTitleStyle_dark,)
                    ],
                  ),
                ),
              );
            }else{
              return SizedBox(height: 1);
            }
          }
      ),
    );
  }
  Widget cardDashborad(){
    
  }

  Future<SharedPreferences> _getPrefs() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs;
  }
}
