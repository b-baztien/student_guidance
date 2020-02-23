import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/page/Edit/EditProfile.dart';
import 'package:student_guidance/page/Tutorials/View_Tutorial.dart';
import 'package:student_guidance/page/dashboard/dashboard.dart';
import 'package:student_guidance/page/home/home.dart';
import 'package:student_guidance/page/login/login-new.dart';
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
    EditProfile.tag: (context) => EditProfile(
          login: Login(),
        ),
  };

  //SharedPreferences
  static Future<SharedPreferences> getPrefs() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs;
  }

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
  static String txSearchWidget = 'สนใจอะไรอยู่ลองค้นหาดูสิ';
  static String txTeacherWidget = 'ข้อมูลติดต่อครู';
  static String txDashboardWidget = 'แผนภูมิ';
  static String txDashboardTitle = 'การศึกษาต่อ';
  static String txSearchBox = 'ค้นหา ?';
  static String txFiltterTitle = 'กรองผลการค้นหา';
  static String txFilterRecommend = 'การค้นหาที่แนะนำ';
  static String btFiltterSuccess = 'กรอง';
  static String btFiltterClose = 'ปิด';
  static String txFilterType = 'ตัวเลือกการกรอง';
  static String txFilterItemUniversity = 'มหาวิทยาลัย';
  static String txFilterItemFaculty = 'คณะ';
  static String txFilterItemMajor = 'สาขา';
  static String txFilterItemCareer = 'อาชีพ';
  static String txCancel = 'ยกเลิก';
  static String txEditProfileTitle = 'แก้ไขข้อมูลส่วนตัว';
  static String txEditSubtitle = 'แก้ไขข้อมูล';

  static String txDashboardStudentAll = 'นักเรียนทั้งหมด';
  static String txDashboardStudentAddUniversity = 'ศึกษาต่อ';
  static String txDashboardStudentNoneUniversity = 'ไม่ศึกษาต่อ';
  static String txDashboardStudentOther = 'อื่นๆ ';

  static String txDashnoardUniversityPop = 'มหาวิทยาลัยยอดนิยม';
  static String imgDashnoardUniversityPop = 'assets/images/Group.png';
  static String txDashnoardFacultyPop = 'คณะยอดนิยม';
  static String imgDashnoardFacultyPop = 'assets/images/Group-Faculty.png';
  static String txDashnoardMajorPop = 'สาขายอดนิยม';
  static String imgDashnoardMajorPop = 'assets/images/Group-Major.png';

  static String txNewsNotfound = 'ไม่พบข่าวสำหรับวันนี้';

  static TextStyle textTitleStyle =
      TextStyle(fontFamily: 'Kanit', fontSize: 20, color: Colors.white);

  static TextStyle textTitleStyleDark =
      TextStyle(fontFamily: 'Kanit', fontSize: 20, color: Colors.black);
  static TextStyle textSubTitleStyle =
      TextStyle(fontFamily: 'Kanit', fontSize: 15, color: Colors.white);
  static TextStyle textSubTitleStyleDark =
      TextStyle(fontFamily: 'Kanit', fontSize: 15, color: Colors.black);

  static TextStyle textNewsTitleStyleDark =
      TextStyle(fontFamily: 'Kanit', fontSize: 20, color: Colors.black);

  static TextStyle textSubTitleStyle_9 =
      TextStyle(fontFamily: 'Kanit', fontSize: 9);
  static TextStyle textSubTitleStyle_12 =
      TextStyle(fontFamily: 'Kanit', fontSize: 12);

  static TextStyle textDashboardTitleStyle15Pink =
      TextStyle(fontFamily: 'Kanit', fontSize: 15, color: Color(0xffFFADAD));

  static TextStyle textSearchTitleStyle24Blue =
  TextStyle(fontFamily: 'Kanit', fontSize: 24, color: Color(0xff005BC7));

  static TextStyle textSearchSubTitleStyle13Blue =
  TextStyle(fontFamily: 'Kanit', fontSize: 13, color: Color(0xff005BC7));
  static TextStyle textSearchSubTitleStyle13Black =
  TextStyle(fontFamily: 'Kanit', fontSize: 13, color: Colors.black);
  static TextStyle textDashboardTitleStyle15Dark =
      TextStyle(fontFamily: 'Kanit', fontSize: 15, color: Colors.black87);

  static TextStyle textSearchTitleStyle20Orange =
  TextStyle(fontFamily: 'Kanit', fontSize: 20, color: Color(0xffFF9211));
  static TextStyle textDashboardTitleStyle15White =
      TextStyle(fontFamily: 'Kanit', fontSize: 15, color: Colors.white);
  static TextStyle textDashboardSubTitleStyle12White =
      TextStyle(fontFamily: 'Kanit', fontSize: 15, color: Colors.white);
}
