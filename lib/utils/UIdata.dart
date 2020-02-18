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
  static String tx_dashboard_widget = 'แผนภูมิ';
  static String tx_dashboard_title = 'การศึกษาต่อ';
  static String tx_search_box = 'ค้นหา ?';
  static String tx_filtter_title = 'กรองผลการค้นหา';
  static String tx_filter_recommend = 'การค้นหาที่แนะนำ';
  static String bt_filtter_success = 'กรอง';
  static String bt_filtter_close = 'ปิด';
  static String tx_filter_type = 'ตัวเลือกการกรอง';
  static String tx_filter_item_university = 'มหาวิทยาลัย';
  static String tx_filter_item_faculty = 'คณะ';
  static String tx_filter_item_major = 'สาขา';
  static String tx_filter_item_career = 'อาชีพ';

  static String tx_edit_profile_title = 'แก้ไขข้อมูลส่วนตัว';
  static String tx_edit_subtitle = 'แก้ไขข้อมูล';

  static String tx_dashboard_student_all = 'นักเรียนทั้งหมด';
  static String tx_dashboard_student_add_university = 'ศึกษาต่อ';
  static String tx_dashboard_student_none_university = 'ไม่ศึกษาต่อ';
  static String tx_dashboard_student_other = 'อื่นๆ ';

  static String tx_dashnoard_university_pop = 'มหาวิทยาลัยยอดนิยม';
  static String tx_dashnoard_faculty_pop = 'คณะยอดนิยม';
  static String tx_dashnoard_major_pop = 'สาขายอดนิยม';


  static TextStyle textTitleStyle = TextStyle(fontFamily: 'Kanit',fontSize: 20,color:Colors.white);

  static TextStyle textTitleStyle_dark = TextStyle(fontFamily: 'Kanit',fontSize: 20,color:Colors.black);
  static TextStyle textSubTitleStyle = TextStyle(fontFamily: 'Kanit',fontSize: 15,color:Colors.white);
  static TextStyle textSubTitleStyle_dark = TextStyle(fontFamily: 'Kanit',fontSize: 15,color:Colors.black);


  static TextStyle textSubTitleStyle_9 = TextStyle(fontFamily: 'Kanit',fontSize:9);
  static TextStyle textSubTitleStyle_12 = TextStyle(fontFamily: 'Kanit',fontSize:12);

  static TextStyle text_Dashboard_TitleStyle_15_pink = TextStyle(fontFamily: 'Kanit',fontSize:15,color: Colors.pink.shade300);
  static TextStyle text_Dashboard_TitleStyle_15_white = TextStyle(fontFamily: 'Kanit',fontSize:15,color: Colors.white);
  static TextStyle text_Dashboard_subTitleStyle_12_white = TextStyle(fontFamily: 'Kanit',fontSize:15,color: Colors.white);
}
