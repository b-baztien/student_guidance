import 'package:flutter/material.dart';
import 'package:student_guidance/utils/UIdata.dart';

class MyFilterDrawer extends StatefulWidget {
  @override
  _MyFilterDrawerState createState() => _MyFilterDrawerState();
}

class _MyFilterDrawerState extends State<MyFilterDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 40),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black45)]),
        width: 300,
        child: SafeArea(
          child: Column(

            children: <Widget>[
              Text(
             UIdata.tx_filtter_title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
             Expanded(
               child: Align(
                 alignment: FractionalOffset.bottomCenter,
                 child: Padding(
                   padding: const EdgeInsets.all(20),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       RaisedButton(
                         color: Colors.green,
                         child: Text(UIdata.bt_filtter_success,style: TextStyle(color: Colors.white),),
                         onPressed: (){
                           setState(() {
                             print('okayyyy');
                           });
                         },
                       ),
                       RaisedButton(
                         child: Text(UIdata.bt_filtter_close),
                         onPressed: (){
                           setState(() {
                             Navigator.pop(context);
                             print('Close');
                           });
                         },
                       )
                     ],
                   ),
                 ),
               ),
             )
            ],
          ),
        ),
      ),
    );
  }
}
