

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/page/drawer/MyFilterDrawer.dart';
import 'package:student_guidance/page/drawer/Mydrawer.dart';
import 'package:student_guidance/utils/UIdata.dart';

class SearchWidgetNew extends StatefulWidget {

  @override
  _SearchWidgetNewState createState() => _SearchWidgetNewState();
}

class _SearchWidgetNewState extends State<SearchWidgetNew> {
  var _scaffordKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/thembg.png"), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          child: FutureBuilder(
            future: _getPrefs(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return Scaffold(
                  key: _scaffordKey,
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(

                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title: Text(UIdata.tx_search_widget,style: UIdata.textTitleStyle,),
                    actions: <Widget>[
                      Container()
                    ],
                  ),
                  drawer: MyDrawer(student:
                  Student.fromJson(
                      jsonDecode(snapshot.data.getString('student'))),
                      schoolId:snapshot.data.getString('schoolId')
                  ),
                  endDrawer: MyFilterDrawer(),
                  body: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Column(

                            children: <Widget>[
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: TextField(
                                    onChanged: (value) {

                                    },
                                    //  controller: _controller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: UIdata.themeColor,
                                          size: 25.0,
                                        ),
                                        contentPadding:
                                        EdgeInsets.only(left: 10.0, top: 12.0),
                                        hintText: UIdata.tx_search_box,
                                        hintStyle: TextStyle(color: Colors.grey),
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: () {


                                          },
                                        )),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10,bottom: 10),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 26,top: 5,bottom: 5,right: 5),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'พบทั้งหมด 10 รายการ',
                                style: TextStyle(
                                    color: UIdata.themeColor, fontFamily: UIdata.fontFamily),
                              ),
                              IconButton(
                              icon:  Icon(
                              Icons.filter_list,
                                color: Colors.black,

                              ) ,
                                onPressed: (){
                                    _scaffordKey.currentState.openEndDrawer();
                                },
                              )
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                );
              }else{
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    title: Text(UIdata.tx_search_widget,style: UIdata.textTitleStyle,),
                  ),
                  drawer: Drawer(
                    elevation: 0,
                  ),
                );
              }
            },
          ),
        )
      ],
    );





  }

  Future<SharedPreferences> _getPrefs() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs;
  }
}

