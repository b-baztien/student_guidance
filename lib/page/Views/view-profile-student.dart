import 'package:flutter/material.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/page/add_data/add_education.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/service/LoginService.dart';
import 'package:student_guidance/service/StudentService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  Student student = new Student();
  @override
  void initState() {
    super.initState();
    StudentService().getStudent().then((studentFromService) {
      setState(() {
        student = studentFromService;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 180,
            decoration: BoxDecoration(color: UIdata.themeColor),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      'โปรไฟล์',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: ListView(
              children: <Widget>[
                new CardHolder(
                  student: student,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardHolder extends StatelessWidget {
  final Student student;
  const CardHolder({
    Key key,
    this.student,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      margin: EdgeInsets.only(top: 100, right: 20, left: 20),
      width: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Color(0xff444444).withOpacity(.1),
                blurRadius: 20,
                spreadRadius: 10),
          ]),
      child: new Card(),
    );
  }
}

class Card extends StatefulWidget {
  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<Card> {
  String email = '';
  String name = '';
  String status = '';
  String year = '';
  String plan = '';
  String oldschool = '';
  String img = '';
  @override
  void initState() {
    super.initState();
    StudentService().getStudent().then((studentFromService) {
      GetImageService()
          .getImage(studentFromService.image)
          .then((imgFromService) {
        setState(() {
          name =
              studentFromService.firstname + ' ' + studentFromService.lastname;
          email = studentFromService.email;
          status = studentFromService.status;
          year = studentFromService.entryyear;
          plan = studentFromService.plan;
          oldschool = studentFromService.juniorSchool;
          img = imgFromService;
          print(img);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: NetworkImage(img), fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                  color: UIdata.themeColor.withOpacity(.2), width: 1)),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(
            color: Color(0xff444444),
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              email,
              style: TextStyle(color: UIdata.themeColor, fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 12,
              child: VerticalDivider(
                width: 2,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              status,
              style: TextStyle(color: Colors.green, fontSize: 15),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.only(left: 20, right: 20, top: 8),
          width: 320,
          height: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 30,
                    spreadRadius: 5)
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'ปีการศึกษา ' + year,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'แผนการเรียน ' + plan,
                        style: TextStyle(
                          color: UIdata.themeColor,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
              Text(
                'โรงเรียนเดิม ' + oldschool,
                style: TextStyle(
                  color: Colors.orange[500],
                ),
              ),
              SizedBox(
                height: 3,
              ),
            ],
          ),
        ),
        Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 8),
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: UIdata.themeColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 6.0),
                        child: Text(
                          "จัดการข้อมูลส่วนตัว",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: UIdata.fontFamily,
                              fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddEducation()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              Icons.add_box,
                              color: Colors.green,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'เพิ่มข้อมูลการสอบติด',
                            style: TextStyle(
                                color: Color(0xFFa9a9a9), fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Divider(
                    height: 1,
                    color: Color(0xff444444).withOpacity(.3),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddEducation()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              Icons.school,
                              color: Colors.blue,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'เลือกมหาวิทยาลัยที่ชอบ',
                            style: TextStyle(
                                color: Color(0xFFa9a9a9), fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Divider(
                    height: 1,
                    color: Color(0xff444444).withOpacity(.3),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: InkWell(
                          onTap: () {
                            logout();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.orange,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'เลือกอาชีพที่ชอบ',
                            style: TextStyle(
                                color: Color(0xFFa9a9a9), fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 300,
                  child: Divider(
                    height: 1,
                    color: Color(0xff444444).withOpacity(.3),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: InkWell(
                          onTap: () {
                            logout();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              Icons.exit_to_app,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'ออกจากระบบ',
                            style: TextStyle(
                                color: Color(0xFFa9a9a9), fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Future<void> logout() async {
    try {
      await LoginService().remove('login');
      await Navigator.pushNamedAndRemoveUntil(context, UIdata.loginPageTag,
          ModalRoute.withName(UIdata.loginPageTag));
    } catch (error) {
      throw (error);
    }
  }
}
