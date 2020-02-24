import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/service/StudentService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class EditProfile extends StatelessWidget {
  static String tag = 'edit-profile';

  //ตัวแปรรับมาจาก drawer เพื่อเอาไปใช้ต่อ
  final Login login;

  EditProfile({Key key, @required this.login}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/edit-img.png"),
                  fit: BoxFit.fill)),
          child: EditStudentProfile(login)),
    );
  }
}

class EditStudentProfile extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final Login _login;
  Student _student;
  ProgressDialog _progressDialog;

  EditStudentProfile(this._login);
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

  Widget _buildInputText(String value, String labelText, String hintText,
      Function onSaveFunction) {
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
        onSaved: onSaveFunction,
      ),
    );
  }

  Widget _buildButtons(BuildContext context, ProgressDialog _progressDialog) {
    _progressDialog.style(message: 'กำลังโหลด...');
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
                    UIdata.txCancel,
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
              onTap: () async {
                final formState = _globalKey.currentState;
                if (formState.validate()) {
                  formState.save();
                  try {
                    _progressDialog.show();
                    await StudentService()
                        .editStudentProfile(_login.username, _student)
                        .then((result) {
                      _progressDialog.hide();
                      Navigator.pop(context);
                    });
                  } catch (e) {
                    // Navigator.pop(context);
                  }
                }
              },
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
                      UIdata.txEditSubtitle,
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
    _progressDialog = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);

    Size _screenSize = MediaQuery.of(context).size;
    return StreamBuilder<Student>(
        stream: StudentService().getStudentByUsername(_login.username),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _student = snapshot.data;
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  UIdata.txEditProfileTitle,
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
                  child: Form(
                    key: _globalKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: _screenSize.height / 50),
                          _buildProfileImage(),
                          Column(
                            children: <Widget>[
                              _buildDetailInfo(
                                  UIdata.txEditSubtitle, UIdata.textTitleStyle),
                              _buildSeparator(_screenSize),
                              _buildInputText(
                                  _student.firstName,
                                  'ชื่อ',
                                  'กรุณากรอกชื่อ',
                                  (value) => _student.firstName = value),
                              _buildInputText(
                                  _student.lastName,
                                  'นามสกุล',
                                  'กรุณากรอกนามสกุล',
                                  (value) => _student.lastName = value),
                              _buildInputText(
                                  _student.phone,
                                  'เบอร์โทรศัพท์',
                                  'กรุณากรอกเบอร์โทรศัพท์',
                                  (value) => _student.phone = value),
                              _buildInputText(
                                  _student.email,
                                  'อีเมล์',
                                  'กรุณากรอกอีเมล์',
                                  (value) => _student.email = value),
                            ],
                          ),
                          SizedBox(height: 30.0),
                          _buildButtons(context, _progressDialog),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center();
          }
        });
  }
}
