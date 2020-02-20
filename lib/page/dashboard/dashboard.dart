import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: FutureBuilder(
          future: _getPrefs(),
          builder: (context, futureSnapshot){
            if (futureSnapshot.hasData) {
              return  Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text(UIdata.txDashboardWidget,style: UIdata.textTitleStyle,),
                ),
                drawer: MyDrawer(
                    student:
                    Student.fromJson(
                        jsonDecode(futureSnapshot.data.getString('student'))),
                    schoolId:futureSnapshot.data.getString('schoolId')
                ),
                body: Container(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(UIdata.txDashboardTitle,style: UIdata.textTitleStyleDark,),
                      cardDashboradYear(),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _buildCardTop5(Colors.black87,screenWidth /2.1,180,UIdata.txDashnoardUniversityPop,UIdata.textDashboardTitleStyle15Pink,UIdata.imgDashnoardUniversityPop,40,27),
                            _buildCardTop5(Color(0xffF08201),screenWidth /2.5,180,UIdata.txDashnoardFacultyPop,UIdata.textDashboardTitleStyle15Dark,UIdata.imgDashnoardFacultyPop,30,30)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _buildCardTop5(Color(0xff006A82),screenWidth - 37,200,UIdata.txDashnoardMajorPop,UIdata.textDashboardTitleStyle15White,UIdata.imgDashnoardMajorPop,30,30),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }else{
              return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.black,
                  )
              );
            }
          }
      ),
    );
  }
  Widget cardDashboradYear(){
    return Card(
        child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical:10.0),
            leading: Container(
              height: 50,
              padding: EdgeInsets.only(left: 5,right: 12,top: 15),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(
                          width: 1.0, color: Colors.black,))),
              child: Text('ปีการศึกษา 2562',style: TextStyle(fontSize: 12),),
            ),

            title:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
               Column(
                 children: <Widget>[
                   Text(
                       UIdata.txDashboardStudentAll
                           ,style: UIdata.textSubTitleStyle_9,
                   ),
                   Text(
                       '1375'
                     ,style:TextStyle(fontFamily: 'Kanit',fontSize:12,color:Colors.green ),
                   )
                 ],
               ),
                SizedBox(width: 10,),
                Column(
                  children: <Widget>[
                    Text(
                      UIdata.txDashboardStudentAddUniversity
                      ,style: UIdata.textSubTitleStyle_9,
                    ),
                    Text(
                        '1175'

                      ,style:TextStyle(fontFamily: 'Kanit',fontSize:12,color:Colors.lightBlue ),
                    )
                  ],
                ),
                SizedBox(width: 10,),
                Column(
                  children: <Widget>[
                    Text(
                      UIdata.txDashboardStudentNoneUniversity
                      ,style: UIdata.textSubTitleStyle_9,
                    ),
                    Text(
                        '150'
                      ,style:TextStyle(fontFamily: 'Kanit',fontSize:12,color:Colors.deepOrangeAccent ),
                    )
                  ],
                ),
                SizedBox(width: 10,),
                Column(
                  children: <Widget>[
                    Text(
                      UIdata.txDashboardStudentOther
                      ,style: UIdata.textSubTitleStyle_9,
                    ),
                    Text(
                        '50'
                      ,style:TextStyle(fontFamily: 'Kanit',fontSize:12,color:Colors.red ),
                    )
                  ],
                )
              ],
            ),

        )

    );
  }

  Widget _buildCardTop5(Color color,double widthLayout,double hightLayout,String title,TextStyle titleStyle,String assetImage,double widthImg,double hightImg){
    return Container(
      width: widthLayout,
      height: hightLayout,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
         Radius.circular(10)
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(title,style: titleStyle,),
            Text('subTitle',style: UIdata.textDashboardSubTitleStyle12White,),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Container(
                    width: widthImg,
                    height: hightImg,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(assetImage),
                        fit: BoxFit.fill
                      )
                    ),
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<SharedPreferences> _getPrefs() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs;
  }
}




