import 'package:flutter/material.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  
  final GlobalKey<FormState> _globalKeyChangePassword = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    Size _screenSize = MediaQuery.of(context).size;

    return Material(
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/change-password.png"),
                  fit: BoxFit.fitHeight)),
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
                      padding:  const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Container(
                          child:Form(
                            key: _globalKeyChangePassword,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                          SizedBox(height: _screenSize.height / 50),
                                ],
                              ),
                            ),
                          )
                        ),
                      ),
                ),
              ),
            ),
          ),
    );
  }
}