import 'package:flutter/material.dart';
import 'package:student_guidance/utils/UIdata.dart';

class FilterWidget extends StatefulWidget {
  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           title: Text('ตัวกรอง',
            style: TextStyle(
              color: UIdata.fontColor,
              fontFamily: 'Kanit',
              fontSize: 20,
            )),
        backgroundColor: UIdata.themeColor,
        elevation: 0,
       

      ),
    );
  }
}