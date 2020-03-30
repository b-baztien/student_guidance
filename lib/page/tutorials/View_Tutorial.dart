import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/page/Tutorials/Item_Tutorial.dart';
import 'package:student_guidance/utils/UIdata.dart';
import 'package:student_guidance/widgets/swiper_pagination.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Tutorials extends StatefulWidget {
  static String tag = 'tutorials-page';

  @override
  _TutorialsState createState() => _TutorialsState();
}

class _TutorialsState extends State<Tutorials> {
  SwiperController _controller = SwiperController();
  final int _pageCount = 3;
  int _currentIndex = 0;
  final List<String> titles = [
    "Student Guidance",
    "การค้นหาข้อมูล ?",
    "การตัดสินใจ ?",
  ];
  final List<String> subtitles = [
    "แอพพลิเคชันที่จะช่วยแนะนำให้นักเรียน สามารถตรวจสอบรายละเอียดการศึกษาต่อในระดับมหาวิทยาลัย",
    "ภายในตัวแอพพลิเคชันได้เตรียมข้อมูลมหาวิทยาลัยต่างๆ ไว้ให้ผู้ใช้ค้นหาอย่างง่ายดาย",
    "ระบบข้อมูลข่าวสารเกี่ยวกับ TCAS พร้อมทั้ง Dashboard ข้อมูลสถานศึกษาต่อของศิษย์เก่าในแต่ละรุ่น เพื่อช่วยในการตัดสินใจ",
  ];
  final List<String> images = [
    'assets/images/tutorial-1.jpg',
    'assets/images/tutorial-2.jpg',
    'assets/images/tutorial-3.jpg'
  ];
  final List<Color> colors = [
    Colors.brown.shade300,
    Colors.blueGrey.shade300,
    Colors.indigo.shade300
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Swiper(
              loop: false,
              index: _currentIndex,
              itemCount: _pageCount,
              controller: _controller,
              onIndexChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              pagination: SwiperPagination(
                  builder: CustomePaginationBuilder(
                      activeSize: Size(15, 25),
                      size: Size(10, 20),
                      color: Colors.grey.shade300,
                      activeColor: Colors.green)
                      ),
              itemBuilder: (BuildContext context, int index) {
                return ItemTutorial(
                  title: titles[index],
                  subtitle: subtitles[index],
                  bg: colors[index],
                  image: images[index],
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: FlatButton(
                child: Text(
                  'ข้าม',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      UIdata.loginPageTag,
                      ModalRoute.withName(UIdata.loginPageTag));
                },
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(
                    _currentIndex < _pageCount - 1
                        ? Icons.arrow_forward_ios
                        : FontAwesomeIcons.check,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    if (_currentIndex != 2) {
                      _controller.next();
                    } else {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool('first_time', false);
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          UIdata.loginPageTag,
                          ModalRoute.withName(UIdata.loginPageTag));
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
