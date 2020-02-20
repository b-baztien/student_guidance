import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/FilterSeachItems.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/page/drawer/MyFilterDrawer.dart';
import 'package:student_guidance/page/drawer/Mydrawer.dart';
import 'package:student_guidance/page/search/ItemFaculty.dart';
import 'package:student_guidance/page/search/ItemMajor.dart';
import 'package:student_guidance/page/search/ItemsUniversity.dart';
import 'package:student_guidance/page/search/Widget_Item_Career.dart';
import 'package:student_guidance/service/SearchService.dart';
import 'package:student_guidance/service/UniversityService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class SearchWidgetNew extends StatefulWidget {
  @override
  _SearchWidgetNewState createState() => _SearchWidgetNewState();
}

class _SearchWidgetNewState extends State<SearchWidgetNew> {
  var _scaffordKey = new GlobalKey<ScaffoldState>();
<<<<<<< HEAD
  String type = 'University';
=======
>>>>>>> 3bdd0e66129b6510358d434d20584d8e6fbe7aed

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/thembg.png"), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          child: FutureBuilder(
            future: _getPrefs(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scaffold(
                  key: _scaffordKey,
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title: Text(
                      UIdata.txSearchWidget,
                      style: UIdata.textTitleStyle,
                    ),
                    actions: <Widget>[Container()],
                  ),
                  drawer: MyDrawer(
                      student: Student.fromJson(
                          jsonDecode(snapshot.data.getString('student'))),
                      schoolId: snapshot.data.getString('schoolId')),
                  endDrawer: MyFilterDrawer(),
                  body: Column(
<<<<<<< HEAD
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
=======
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 12.0, right: 12.0),
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: TextField(
                                    onChanged: (value) {},
                                    //  controller: _controller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: UIdata.themeColor,
                                          size: 25.0,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 10.0, top: 12.0),
                                        hintText: UIdata.txSearchBox,
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: () {},
                                        )),
>>>>>>> 3bdd0e66129b6510358d434d20584d8e6fbe7aed
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
<<<<<<< HEAD
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
                        _buildExpendedSearch(type)


                      ],
                    ),
=======
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(
                                left: 26, top: 5, bottom: 5, right: 5),
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
                                      color: UIdata.themeColor,
                                      fontFamily: UIdata.fontFamily),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.filter_list,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    _scaffordKey.currentState.openEndDrawer();
                                  },
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
>>>>>>> 3bdd0e66129b6510358d434d20584d8e6fbe7aed
                );
              } else {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    title: Text(
                      UIdata.txSearchWidget,
                      style: UIdata.textTitleStyle,
                    ),
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

  Widget _buildExpendedSearch(String type){
    return Expanded(
      child: StreamBuilder(
        stream: SearchService().getAllSearchItem(),
        builder: (context,snapshot){
            if(snapshot.hasData){
              List<FilterSeachItems> list = snapshot.data;
              List<FilterSeachItems> listItem = new  List<FilterSeachItems>();
              for(FilterSeachItems f in list){
                print(f.type);
                if(f.type == type){
                  listItem.add(f);
                }
              }
              print(listItem.length);
              return ListView.separated(
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: () {
                        UniversityService().updateView(list[index].documentSnapshot);
                        if (list[index].type == 'University') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemUniversity(
                                      universitys: list[index].documentSnapshot)));
                        }
                        if(list[index].type == 'Faculty'){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemFaculty(
                                      facultyName: list[index].name)));
                        }
                        if(list[index].type == 'Major'){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemMajor(
                                      majorName: list[index].name)));
                        }
                        if(list[index].type == 'Career'){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemCareer(
                                      career: list[index].name)));
                        }
                      },
                      child: Container(
                          child: ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                              leading: Container(
                                padding: EdgeInsets.only(right: 5.0),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        right: new BorderSide(
                                            width: 1.0, color: Colors.black)
                                    )
                                ),
                                child: Text(listItem[index].type),
                              ),

                              title: Text(
                                listItem[index].name,
                                style: TextStyle(
                                    color: UIdata.themeColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(Icons.keyboard_arrow_right,
                                  color: Colors.black, size: 30.0)
                          )
                      ),

                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.black,
                  ),
                  itemCount: listItem.length);
            }else{
              return SizedBox(height: 1);

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
