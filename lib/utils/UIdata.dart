import 'package:flutter/material.dart';
import 'package:student_guidance/page/Edit/EditProfile.dart';
import 'package:student_guidance/page/Tutorials/View_Tutorial.dart';
import 'package:student_guidance/page/dashboard/dashboard.dart';
import 'package:student_guidance/page/home/home.dart';
import 'package:student_guidance/page/login/login-new.dart';
import 'package:student_guidance/page/login/login.dart';
import 'package:student_guidance/page/splash/splash.dart';

class UIdata {
  static Icon backIcon = new Icon(Icons.arrow_back_ios);
  static Icon menuIcon = new Icon(Icons.menu);
  static Icon searchIcon = new Icon(Icons.search);

  static Map<String, WidgetBuilder> routes = {
    LoginPages.tag: (context) => LoginPages(),
    SplashPage.tag: (context) => SplashPage(),
    Home.tag: (context) => Home(),
    Tutorials.tag: (context) => Tutorials(),
    Dashboard.tag: (context) => Dashboard(),
    EditProfile.tag: (context) => EditProfile(),
  };
  /*tag page */
  static String loginPageTag = LoginPages.tag;
  static String homeTag = Home.tag;
  static String splashPage = SplashPage.tag;
  static String tutorialTag = Tutorials.tag;
  static String dashboardTag = Dashboard.tag;
  static String editProfileTag = EditProfile.tag;
  static String fontFamily = 'Kanit';
  static Color themeColor = Colors.blue[400];
  static MaterialColor themeMaterialColor = Colors.blue;
  static Color fontColor = Colors.white;



  /*String Text*/
  static String tx_search_widget = 'สนใจอะไรอยู่ลองค้นหาดูสิ';
  static String tx_teacher_widget = 'ข้อมูลติดต่อครู';
  static String tx_search_box = 'ค้นหา ?';
  static String tx_filtter_title = 'กรองผลการค้นหา';
  static String bt_filtter_success = 'กรอง';
  static String bt_filtter_close = 'ปิด';



  static TextStyle textTitleStyle = TextStyle(fontFamily: 'Kanit',fontSize: 20,color:Colors.white);
  static TextStyle textSubTitleStyle = TextStyle(fontFamily: 'Kanit',fontSize: 15,color:Colors.white);


}
