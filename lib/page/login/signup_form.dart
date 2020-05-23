import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/service/LoginService.dart';
import 'package:student_guidance/service/RegisterService.dart';
import 'package:student_guidance/service/SchoolService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String _dropdownProvinceValue;
  List _dropdownProvinceData = UIdata.provinceData;

  String _dropdownSchoolValue;
  List<DocumentSnapshot> _dropdownSchoolData;

  String _firstName, _lastName, _email, _username, _password;

  @override
  Widget build(BuildContext context) {
    ProgressDialog _progressDialog =
        new ProgressDialog(context, type: ProgressDialogType.Normal);
    _progressDialog.style(message: 'กำลังโหลด...');

    Future<void> register() async {
      final formState = _globalKey.currentState;
      if (formState.validate()) {
        formState.save();
        try {
          Student student = new Student();
          student.firstName = _firstName;
          student.lastName = _lastName;
          student.email = _email;
          student.province = _dropdownProvinceValue;
          student.status = 'กำลังศึกษา';

          Login login = new Login();
          login.username = _username.trim();
          login.password = _password;
          login.type = 'student';

          _progressDialog.show();
          await RegisterService()
              .register(_dropdownSchoolValue, student, login);
          await LoginService().login(login);
          await Navigator.pushNamedAndRemoveUntil(
              context, UIdata.homeTag, ModalRoute.withName(UIdata.homeTag));
        } catch (e) {
          _progressDialog.hide();
          Scaffold.of(context)
              .showSnackBar(UIdata.dangerSnackBar(e.toString()));
        }
      }
    }

    return FutureBuilder<List<DocumentSnapshot>>(
        future: SchoolService().getAllSchool(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _dropdownSchoolData = snapshot.data;
            return Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Form(
                key: _globalKey,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  children: <Widget>[
                    DropdownButtonFormField<String>(
                      value: _dropdownSchoolValue,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
                      onChanged: (String newValue) {
                        setState(() {
                          _dropdownSchoolValue = newValue;
                        });
                      },
                      hint: DropdownMenuItem<String>(
                        value: null,
                        child: Text(
                          'เลือกโรงเรียน',
                          style: TextStyle(fontFamily: UIdata.fontFamily),
                        ),
                      ),
                      validator: (String input) {
                        if (input.isEmpty) {
                          return 'กรุณาเลือกโรงเรียน';
                        }
                        return null;
                      },
                      items: _dropdownSchoolData
                          .map((schoolSnap) =>
                              schoolSnap.data['school_name'].toString())
                          .toList()
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontFamily: UIdata.fontFamily),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "ชื่อ",
                          floatingLabelBehavior: FloatingLabelBehavior.auto),
                      validator: (String input) {
                        if (input.isEmpty) {
                          return 'กรุณากรอกชื่อ';
                        }
                        return null;
                      },
                      onSaved: (input) => _firstName = input,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "นามสกุล",
                          floatingLabelBehavior: FloatingLabelBehavior.auto),
                      validator: (String input) {
                        if (input.isEmpty) {
                          return 'กรุณากรอกนามสกุล';
                        }
                        return null;
                      },
                      onSaved: (input) => _lastName = input,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "อีเมล",
                          floatingLabelBehavior: FloatingLabelBehavior.auto),
                      validator: (String input) {
                        if (input.isEmpty) {
                          return 'กรุณากรอกอีเมล';
                        }
                        return null;
                      },
                      onSaved: (input) => _email = input,
                    ),
                    const SizedBox(height: 10.0),
                    DropdownButtonFormField<String>(
                      value: _dropdownProvinceValue,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
                      onChanged: (String newValue) {
                        setState(() {
                          _dropdownProvinceValue = newValue;
                        });
                      },
                      validator: (String input) {
                        if (input.isEmpty) {
                          return 'กรุณาเลือกจังหวัด';
                        }
                        return null;
                      },
                      hint: DropdownMenuItem<String>(
                        value: null,
                        child: Text(
                          'เลือกจังหวัด',
                          style: TextStyle(fontFamily: UIdata.fontFamily),
                        ),
                      ),
                      items: _dropdownProvinceData
                          .map((provinceData) =>
                              provinceData['province_name'] as String)
                          .toList()
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontFamily: UIdata.fontFamily),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "ไอดีผู้ใช้(รหัสนักเรียน)",
                          floatingLabelBehavior: FloatingLabelBehavior.auto),
                      validator: (String input) {
                        if (input.isEmpty) {
                          return 'กรุณากรอกไอดีผู้ใช้(รหัสนักเรียน)';
                        }
                        return null;
                      },
                      onSaved: (input) => _username = input,
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(labelText: "รหัสผ่าน"),
                      validator: (String input) {
                        if (input.isEmpty) {
                          return 'กรุณากรอกรหัสผ่าน';
                        }
                        return null;
                      },
                      onChanged: (input) => _password = input,
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "ยืนยันรหัสผ่าน",
                          floatingLabelBehavior: FloatingLabelBehavior.auto),
                      validator: (String input) {
                        if (input.isEmpty) {
                          return 'กรุณากรอกยืนยันรหัสผ่าน';
                        } else if (input != _password) {
                          return 'กรุณากรอกรหัสผ่านให้ตรงกัน';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    RaisedButton(
                      color: Colors.brown,
                      textColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text("ลงทะเบียน"),
                      onPressed: register,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
