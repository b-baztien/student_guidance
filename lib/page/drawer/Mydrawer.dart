import 'package:flutter/material.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/page/Edit/ChangePassword.dart';
import 'package:student_guidance/page/Edit/EditProfile.dart';
import 'package:student_guidance/page/Views/list-favorite.dart';
import 'package:student_guidance/page/add_data/add_education_new.dart';
import 'package:student_guidance/page/add_data/add_entrance_major.dart';
import 'package:student_guidance/page/add_data/add_recommend.dart';
import 'package:student_guidance/page/add_data/add_recommend_carrer.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/utils/OvalRighBorberClipper.dart';
import 'package:student_guidance/utils/UIdata.dart';
import 'package:student_guidance/widgets/Dialogs.dart';

class MyDrawer extends StatefulWidget {
  final String schoolId;

  final Student student;
  final Login login;

  const MyDrawer({Key key, this.schoolId, this.student, this.login})
      : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalRighBorderClipper(),
      child: Drawer(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 40),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: Colors.red.shade800,
                      ),
                      onPressed: () {
                        _alertDialog(context);
                      }),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [Colors.orange, Colors.deepOrange])),
                  child: FutureBuilder(
                      future: GetImageService().getImage(widget.student.image),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data),
                            radius: 40,
                          );
                        } else {
                          return CircleAvatar(
                            radius: 40,
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.student.firstName + ' ' + widget.student.lastName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: UIdata.fontFamily),
                ),
                Text(
                  widget.schoolId,
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 15,
                      fontFamily: UIdata.fontFamily),
                ),
                Text(
                  widget.student.status,
                  style: TextStyle(
                      color: widget.student.status == 'กำลังศึกษา'
                          ? Colors.green
                          : Colors.orange,
                      fontSize: 15,
                      fontFamily: UIdata.fontFamily),
                ),
                SizedBox(
                  height: 15,
                ),
                _buildRow(
                  Icons.account_circle,
                  "แก้ไขข้อมูลส่วนตัว",
                  Colors.blue,
                  (context) => EditProfile(
                    login: widget.login,
                  ),
                ),
                _buildDivider(),
                widget.student.status == 'กำลังศึกษา'
                    ? _buildRow(
                        Icons.add_to_photos,
                        "เพิ่มข้อมูลการสอบ TCAS",
                        Colors.green,
                        (context) => AddEducationNew(),
                      )
                    : _buildRow(
                        Icons.add_to_photos,
                        "เพิ่มข้อมูลหลังการจบการศึกษา",
                        Colors.green,
                        (context) => AddEntranceMajor(),
                      ),
                _buildDivider(),
                _buildRow(
                  Icons.favorite,
                  "สาขาที่ติดตาม",
                  Colors.red[300],
                  (context) => ListFavorite(login: widget.login),
                ),
                _buildDivider(),
                _buildRow(
                  Icons.favorite,
                  "RECOMMEND",
                  Colors.red[300],
                  (context) => AddRecommend(),
                ),
                _buildDivider(),
                _buildRow(
                  Icons.favorite,
                  "RECOMMENDCARRER",
                  Colors.red[300],
                  (context) => AddRecommendCarrer(),
                ),
                _buildDivider(),
                _buildRow(Icons.vpn_key, "เปลี่ยนพาสเวิร์ด", Colors.yellow,
                    (context) => ChangePassword()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _alertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialogs();
        });
  }

  Divider _buildDivider() {
    return Divider(
      color: Colors.deepOrange,
    );
  }

  Widget _buildRow(IconData icon, String title, Color colors,
      Function(BuildContext) functionPageBuilder) {
    final TextStyle textStyle =
        TextStyle(color: Colors.black, fontFamily: 'Kanit', fontSize: 15);
    return ListTile(
      onTap: () async {
        final String result = await Navigator.push(
          context,
          MaterialPageRoute(builder: functionPageBuilder),
        );
        if (result != null) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(UIdata.successSnackBar(result));
          Navigator.pop(context);
        }
      },
      leading: Icon(icon, color: colors),
      title: Text(
        title,
        style: textStyle,
      ),
    );
  }
}
