import 'package:flutter/material.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _globalKeyChangePassword = GlobalKey<FormState>();
  Login _login;
  bool _obscureText = true;

  String _password;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;

    return Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/thembg.png"),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              UIdata.txChangePassword,
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
                child: Container(
                    child: Form(
                  key: _globalKeyChangePassword,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: _screenSize.height / 50),
                        _buildDetailInfo(
                            UIdata.txChangePassword, UIdata.textTitleStyle),
                        _buildSeparator(_screenSize),
                        SizedBox(width: _screenSize.width),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 30.0),
                          child: TextFormField(
                            maxLines: 1,
                            decoration: InputDecoration(
                              icon: const Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: const Icon(Icons.lock,
                                      color: Colors.white)),
                              hintText: 'กรุณากรอกรหัสผ่าน',
                              labelText: 'รหัสผ่านใหม่',
                              hintStyle: TextStyle(
                                  fontFamily: UIdata.fontFamily,
                                  color: Colors.white),
                              labelStyle: TextStyle(
                                  fontFamily: UIdata.fontFamily,
                                  color: Colors.white),
                            ),
                            style: TextStyle(
                                fontFamily: UIdata.fontFamily,
                                color: Colors.white),
                            validator: (val) => val.length < 6
                                ? 'รหัสผ่านมากกว่า 6 ตัว.'
                                : null,
                            obscureText: true,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 30.0),
                          child: TextFormField(
                            maxLines: 1,
                            decoration: InputDecoration(
                              icon: const Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: const Icon(Icons.lock,
                                      color: Colors.white)),
                              hintText: 'กรุณากรอกรหัสผ่าน',
                              labelText: 'ยืนยันรหัสผ่านใหม่',
                              hintStyle: TextStyle(
                                  fontFamily: UIdata.fontFamily,
                                  color: Colors.white),
                              labelStyle: TextStyle(
                                  fontFamily: UIdata.fontFamily,
                                  color: Colors.white),
                            ),
                            style: TextStyle(
                                fontFamily: UIdata.fontFamily,
                                color: Colors.white),
                            validator: (val) => val.length < 6
                                ? 'รหัสผ่านมากกว่า 6 ตัว.'
                                : null,
                            onSaved: (val) => _password = val,
                            obscureText: true,
                          ),
                        ),
                        _buildButtons(context),
                      ],
                    ),
                  ),
                )),
              ),
            ),
          ),
        ),
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
                      UIdata.txPassword,
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

  Widget _buildDetailInfo(String detail, TextStyle textStyle) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(detail, style: textStyle),
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

  Widget _buildInputText(
      String labelText, String hintText, Function onSaveFunction) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: TextFormField(
        maxLines: 1,
        decoration: InputDecoration(
          icon: const Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: const Icon(Icons.lock, color: Colors.white)),
          hintText: hintText,
          labelText: labelText,
          hintStyle:
              TextStyle(fontFamily: UIdata.fontFamily, color: Colors.white),
          labelStyle:
              TextStyle(fontFamily: UIdata.fontFamily, color: Colors.white),
        ),
        style: TextStyle(fontFamily: UIdata.fontFamily, color: Colors.white),
        validator: (val) => val.length < 6 ? 'รหัสผ่านมากกว่า 6 ตัว.' : null,
        onSaved: (val) => _password = val,
      ),
    );
  }
}
