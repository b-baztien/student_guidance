import 'package:flutter/material.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class EditProfile extends StatelessWidget {
  static String tag = 'edit-profile';

  //ตัวแปรรับมาจาก drawer เพื่อเอาไปใช้ต่อ
  final Student student;

  EditProfile({Key key, @required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/edit-img.png"),
                  fit: BoxFit.fill)),
          child: EditStudentProfile(student)),
    );
  }
}

class EditStudentProfile extends StatelessWidget {
  final Student _student;

  EditStudentProfile(this._student);
  Widget _buildProfileImage() {
    return Center(
      child: FutureBuilder(
          future: GetImageService().getImage(_student.image),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(snapshot.data),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(80.0),
                  border: Border.all(
                    color: Colors.white,
                    width: 5,
                  ),
                ),
              );
            } else {
              return Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/people-placeholder.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(80.0),
                  border: Border.all(
                    color: Colors.lime,
                    width: 10.0,
                  ),
                ),
              );
            }
          }),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.white,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildDetailInfo(String detail, TextStyle textStyle) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(detail, style: textStyle),
    );
  }

  Widget _buildInputText(String value, String labelText, String hintText) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: TextFormField(
        initialValue: value,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          hintStyle:
              TextStyle(fontFamily: UIdata.fontFamily, color: Colors.white),
          labelStyle:
              TextStyle(fontFamily: UIdata.fontFamily, color: Colors.white),
        ),
        style: TextStyle(fontFamily: UIdata.fontFamily, color: Colors.white),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  color: Colors.red,
                ),
                child: Center(
                  child: Text(
                    UIdata.tx_cancel,
                    style: TextStyle(
                      fontFamily: (UIdata.fontFamily),
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  color: Colors.green,
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      UIdata.tx_edit_subtitle,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: UIdata.fontFamily,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          UIdata.tx_edit_profile_title,
          style: UIdata.textTitleStyle,
        ),
        leading: IconButton(
          icon: UIdata.backIcon,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(

        padding: const EdgeInsets.only(top: 15.0, right: 8, left: 8),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.5),
              border: Border.all(width: 2, color: Colors.white)),
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: _screenSize.height / 50),
                _buildProfileImage(),
                Column(
                  children: <Widget>[
                    _buildDetailInfo(
                        UIdata.tx_edit_subtitle, UIdata.textTitleStyle),
                    _buildSeparator(_screenSize),
                    _buildInputText(
                        _student.firstname, 'ชื่อ', 'กรุณากรอกชื่อ'),
                    _buildInputText(
                        _student.lastname, 'นามสกุล', 'กรุณากรอกนามสกุล'),
                    _buildInputText(_student.phone, 'เบอร์โทรศัพท์',
                        'กรุณากรอกเบอร์โทรศัพท์'),
                    _buildInputText(
                        _student.email, 'อีเมล์', 'กรุณากรอกอีเมล์'),
                  ],
                ),
                SizedBox(height: 30.0),
                _buildButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
