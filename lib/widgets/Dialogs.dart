import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_guidance/service/LoginService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class Dialogs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.only(right: 16),
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(75),
              bottomLeft: Radius.circular(75),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )
          ),
          child: Row(
            children: <Widget>[
              SizedBox(width: 20),
              CircleAvatar(radius: 55,backgroundColor: Colors.grey.shade200,

              child: Icon(FontAwesomeIcons.theaterMasks,size: 80,color: Colors.red,),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   Align(
                     alignment: Alignment.center,
                       child: Text('แจ้งเตือน',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                   ),
                    SizedBox(height: 10),
                    Flexible(
                      child: Text(
                        'กรุณายืนยันที่จะออกจากระบบ !'
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            child: Text('ไม่'),
                            color: Colors.redAccent,
                            colorBrightness: Brightness.dark,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: RaisedButton(
                            child: Text('ใช่'),
                            color: Colors.green,
                            colorBrightness: Brightness.dark,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            onPressed: (){
                              LoginService().clearLoginData();
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  UIdata.loginPageTag,
                                  ModalRoute.withName(UIdata.loginPageTag));
                            },
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
