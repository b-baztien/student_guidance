import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login-1.jpg'),
                  fit: BoxFit.cover,
                )
            ),
          ),
     Align(
         alignment: Alignment.topCenter,
         child: Padding(
           padding: const EdgeInsets.only(top: 50),
           child: Text(
             'Login',
             style: TextStyle(
               color: Colors.white,
               fontWeight: FontWeight.w500,
               fontSize: 30.0,
             ),
           ),
         ),
     ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text(
                'Student Guidance',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'kanit',
                  fontWeight: FontWeight.w500,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
           child: Row(
             children: <Widget>[
               RaisedButton(
                 color: Colors.red,
                 textColor: Colors.white,
                 elevation: 0,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(20)
                 ),
                 child: Text("test"),
                 onPressed: (){

                 },
               )
             ],
           ),
          ),
    
        ],

        ),
      )

    );
  }
}
