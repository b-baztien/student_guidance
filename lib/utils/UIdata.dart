import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  static Icon backIconAndroid = new Icon(Icons.arrow_back);
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
  static String txEducation = 'เพิ่มข้อมูลการสอบติด';
  static String txEntrance = 'เพิ่มข้อมูลการศึกษาต่อ';
  static String txRecommend = 'เลือกสาขาที่สนใจเป็นพิเศษ';
  static String txRecommendCarrer = 'อาชีพที่สนใจ';
  static String txChangePassword = 'เปลี่ยนรหัสผ่าน';
  static String txListFavorite = 'สาขาที่ติดตาม';
  static String txItemUniversityTitle = 'ข้อมูลมหาวิทยาลัย';
  static String txItemCareerTitle = 'ข้อมูลอาชีพ';
  static String txItemFacultyTitle = 'ข้อมูลคณะ';
  static String txItemMajorTitle = 'ข้อมูลสาขา';
  static String txEditSubtitle = 'แก้ไขข้อมูล';

  static String txPassword = 'แก้ไขพาสเวิร์ด';
  static String txContectUniversityButton = 'ข้อมูลติดต่อ';
  static String txDashboardStudentAll = 'นักเรียนทั้งหมด';
  static String txDashboardStudentAddUniversity = 'ศึกษาต่อ';
  static String txDashboardStudentNoneUniversity = 'ไม่ศึกษาต่อ';
  static String txDashboardStudentOther = 'อื่นๆ ';

  static String txDeatilUniversityGroupFaculty = 'กลุ่มคณะ';
  static String txMajorGroup = 'สาขา';
  static String txDashnoardUniversityPop = 'มหาวิทยาลัยยอดนิยม';
  static String imgDashnoardUniversityPop = 'assets/images/Group.png';
  static String txDashnoardFacultyPop = 'คณะยอดนิยม';
  static String imgDashnoardFacultyPop = 'assets/images/Group-Faculty.png';
  static String txDashnoardMajorPop = 'สาขายอดนิยม';
  static String imgDashnoardMajorPop = 'assets/images/Group-Major.png';

  static String txTitleDetailNews = 'รายละเอียดข่าว';
  static String txWebside = 'เว็บไซต์';
  static String txNewsNotfound = 'ไม่พบข่าวสำหรับวันนี้';

  static TextStyle textTitleStyle =
      TextStyle(fontFamily: 'Kanit', fontSize: 20, color: Colors.white);
  static TextStyle textTitleStyle24 =
      TextStyle(fontFamily: 'Kanit', fontSize: 24, color: Colors.white);
  static TextStyle textTitleStyleDark =
      TextStyle(fontFamily: 'Kanit', fontSize: 20, color: Colors.black);
  static TextStyle textTitleStyleDarkUninersity =
      TextStyle(fontFamily: 'Kanit', fontSize: 17, color: Color(0xff545663));
  static TextStyle textTitleStyleDarkBold27 = TextStyle(
      fontFamily: 'Kanit',
      fontSize: 27,
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle textTitleStyleDarkBold = TextStyle(
      fontFamily: 'Kanit',
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold);
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
  static TextStyle textDetailSubTitleStyle_12 =
      TextStyle(fontFamily: 'Kanit', fontSize: 12, color: Colors.white);
  static TextStyle textDashboardTitleStylePink =
      TextStyle(fontFamily: 'Kanit', color: Color(0xffFFADAD));

  static TextStyle textSearchTitleStyle24Blue =
      TextStyle(fontFamily: 'Kanit', fontSize: 24, color: Color(0xff005BC7));

  static TextStyle textSearchSubTitleStyle13Blue =
      TextStyle(fontFamily: 'Kanit', fontSize: 13, color: Color(0xff005BC7));
  static TextStyle textSearchSubTitleStyle13Green =
      TextStyle(fontFamily: 'Kanit', fontSize: 13, color: Colors.green);
  static TextStyle textSearchSubTitleStyle13Red =
      TextStyle(fontFamily: 'Kanit', fontSize: 13, color: Colors.red);
  static TextStyle textSearchSubTitleStyle13Black =
      TextStyle(fontFamily: 'Kanit', fontSize: 13, color: Colors.black);
  static TextStyle textDashboardTitleStyleDark =
      TextStyle(fontFamily: 'Kanit', color: Colors.black87);

  static TextStyle textSearchTitleStyle20Orange =
      TextStyle(fontFamily: 'Kanit', fontSize: 20, color: Color(0xffFF9211));
  static TextStyle textDashboardTitleStyleWhite =
      TextStyle(fontFamily: 'Kanit', color: Colors.white);
  static TextStyle textDashboardSubTitleStyleWhite =
      TextStyle(fontFamily: 'Kanit', color: Colors.white);

//major detail page
  static TextStyle textMajorTitleStyle18Orange =
      TextStyle(fontFamily: 'Kanit', fontSize: 18, color: Color(0xffFF9211));
  static TextStyle textMajorDetailStyle15Grey =
      TextStyle(fontFamily: 'Kanit', fontSize: 15, color: Color(0xff939191));

  static successSnackBar(String message) {
    return SnackBar(
      backgroundColor: Colors.green,
      content: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          Icon(FontAwesomeIcons.solidCheckCircle),
          SizedBox(
            width: 8,
          ),
          Text(
            '$message',
            style: TextStyle(fontSize: 18, fontFamily: UIdata.fontFamily),
          ),
        ],
      ),
    );
  }

  static dangerSnackBar(String message) {
    return SnackBar(
      backgroundColor: Colors.red,
      content: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          Icon(FontAwesomeIcons.exclamationCircle),
          SizedBox(
            width: 8,
          ),
          Text(
            '$message',
            style: TextStyle(fontSize: 15, fontFamily: UIdata.fontFamily),
          ),
        ],
      ),
    );
  }

  static List provinceData = [
    {"province_name": "กระบี่", "zone": "ใต้"},
    {"province_name": "กรุงเทพมหานคร", "zone": "กลาง"},
    {"province_name": "กาญจนบุรี", "zone": "ตะวันตก"},
    {"province_name": "กาฬสินธุ์", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "กำแพงเพชร", "zone": "กลาง"},
    {"province_name": "ขอนแก่น", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "จันทบุรี", "zone": "ตะวันออก"},
    {"province_name": "ฉะเชิงเทรา", "zone": "ตะวันออก"},
    {"province_name": "ชลบุรี", "zone": "ตะวันออก"},
    {"province_name": "ชัยนาท", "zone": "กลาง"},
    {"province_name": "ชัยภูมิ", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "ชุมพร", "zone": "ใต้"},
    {"province_name": "ตรัง", "zone": "ใต้"},
    {"province_name": "ตราด", "zone": "ตะวันออก"},
    {"province_name": "ตาก", "zone": "ตะวันตก"},
    {"province_name": "นครนายก", "zone": "กลาง"},
    {"province_name": "นครปฐม", "zone": "กลาง"},
    {"province_name": "นครพนม", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "นครราชสีมา", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "นครศรีธรรมราช", "zone": "ใต้"},
    {"province_name": "นครสวรรค์", "zone": "กลาง"},
    {"province_name": "นนทบุรี", "zone": "กลาง"},
    {"province_name": "นราธิวาส", "zone": "ใต้"},
    {"province_name": "น่าน", "zone": "เหนือ"},
    {"province_name": "บึงกาฬ", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "บุรีรัมย์", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "ปทุมธานี", "zone": "กลาง"},
    {"province_name": "ประจวบคีรีขันธ์", "zone": "ตะวันตก"},
    {"province_name": "ปราจีนบุรี", "zone": "ตะวันออก"},
    {"province_name": "ปัตตานี", "zone": "ใต้"},
    {"province_name": "พระนครศรีอยุธยา", "zone": "กลาง"},
    {"province_name": "พะเยา", "zone": "เหนือ"},
    {"province_name": "พังงา", "zone": "ใต้"},
    {"province_name": "พัทลุง", "zone": "ใต้"},
    {"province_name": "พิจิตร", "zone": "กลาง"},
    {"province_name": "พิษณุโลก", "zone": "กลาง"},
    {"province_name": "ภูเก็ต", "zone": "ใต้"},
    {"province_name": "มหาสารคาม", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "มุกดาหาร", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "ยะลา", "zone": "ใต้"},
    {"province_name": "ยโสธร", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "ระนอง", "zone": "ใต้"},
    {"province_name": "ระยอง", "zone": "ตะวันออก"},
    {"province_name": "ราชบุรี", "zone": "ตะวันตก"},
    {"province_name": "ร้อยเอ็ด", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "ลพบุรี", "zone": "กลาง"},
    {"province_name": "ลำปาง", "zone": "เหนือ"},
    {"province_name": "ลำพูน", "zone": "เหนือ"},
    {"province_name": "ศรีสะเกษ", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "สกลนคร", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "สงขลา", "zone": "ใต้"},
    {"province_name": "สตูล", "zone": "ใต้"},
    {"province_name": "สมุทรปราการ", "zone": "กลาง"},
    {"province_name": "สมุทรสงคราม", "zone": "กลาง"},
    {"province_name": "สมุทรสาคร", "zone": "กลาง"},
    {"province_name": "สระบุรี", "zone": "กลาง"},
    {"province_name": "สระแก้ว", "zone": "ตะวันออก"},
    {"province_name": "สิงห์บุรี", "zone": "กลาง"},
    {"province_name": "สุพรรณบุรี", "zone": "กลาง"},
    {"province_name": "สุราษฎร์ธานี", "zone": "ใต้"},
    {"province_name": "สุรินทร์", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "สุโขทัย", "zone": "กลาง"},
    {"province_name": "หนองคาย", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "หนองบัวลำภู", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "อำนาจเจริญ", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "อุดรธานี", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "อุตรดิตถ์", "zone": "เหนือ"},
    {"province_name": "อุทัยธานี", "zone": "กลาง"},
    {"province_name": "อุบลราชธานี", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "อ่างทอง", "zone": "กลาง"},
    {"province_name": "เชียงราย", "zone": "เหนือ"},
    {"province_name": "เชียงใหม่", "zone": "เหนือ"},
    {"province_name": "เพชรบุรี", "zone": "ตะวันตก"},
    {"province_name": "เพชรบูรณ์", "zone": "กลาง"},
    {"province_name": "เลย", "zone": "ตะวันออกเฉียงเหนือ"},
    {"province_name": "แพร่", "zone": "เหนือ"},
    {"province_name": "แม่ฮ่องสอน", "zone": "เหนือ"}
  ];
}
