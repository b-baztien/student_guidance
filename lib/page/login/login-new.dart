import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool formVisible;
  int _formsIndex;
  @override
  void initState() {
    super.initState();
    formVisible = false;
    _formsIndex = 1;
  }
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
             'ล็อคอิน',
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
            child: Padding(
                padding: EdgeInsets.only(bottom: 100,left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
               Expanded(
                 child: RaisedButton(
                    color: Colors.blueAccent,
                   textColor: Colors.white,
                   child: Text("ลงชื่อเข้าใข้"),
                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20)
                   ),
                   onPressed: (){
                      setState(() {
                        formVisible = true;
                        _formsIndex = 1;
                      });
                     print("111");
                   },
                 ),
               ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.grey.shade700,
                      textColor: Colors.white,
                      child: Text("สมัครสมาชิก"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      onPressed: (){
                       setState(() {
                         formVisible = true;
                         _formsIndex = 2;
                       });
                        print("22");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: (!formVisible) ? null : Container(
              color: Colors.black54,
              alignment: Alignment.center,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            color: _formsIndex == 1 ?Colors.blueAccent : Colors.white,
                            textColor: _formsIndex == 1 ? Colors.white : Colors.black,
                            child: Text("ลงชื่อเข้าใช้"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            onPressed: (){
                              setState(() {
                                _formsIndex = 1;
                              });
                            },
                          ),
                          const SizedBox(width: 10,),
                          RaisedButton(
                            color: _formsIndex == 2 ?Colors.blueAccent : Colors.white,
                            textColor: _formsIndex == 2 ? Colors.white : Colors.black,
                            child: Text("สมัครสมาชิก"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            onPressed: (){
                              setState(() {
                                _formsIndex = 2;
                              });
                            },
                          ),
                          const SizedBox(width: 10,),
                          IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.clear),
                            onPressed: (){
                              setState(() {
                                formVisible = false;
                              });
                            },
                          )
                        ],
                      ),
                      Container(
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child:
                          _formsIndex == 1 ? LoginForm() : SignupForm(),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),


        ],

        ),
      )

    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
            labelText: "ไอดีผู้ใช้",
              hasFloatingPlaceholder: true
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: "รหัสผ่าน",
                hasFloatingPlaceholder: true
            ),
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.blueAccent,
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("Login"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                labelText: "ชื่อ",
                hasFloatingPlaceholder: true
            ),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "นามสกุล",
                hasFloatingPlaceholder: true
            ),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "อีเมล",
                hasFloatingPlaceholder: true
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(
                labelText: "ไอดีผู้ใช้",
                hasFloatingPlaceholder: true
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
                labelText: "รหัสผ่าน",
                hasFloatingPlaceholder: true
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
                labelText: "ยืนยันรหัสผ่าน",
                hasFloatingPlaceholder: true
            ),
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.blueAccent,
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("Signup"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}