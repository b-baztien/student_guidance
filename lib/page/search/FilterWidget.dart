import 'package:flutter/material.dart';

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
              color: Colors.orange[200],
              fontFamily: 'Kanit',
              fontSize: 20,
            )),
        backgroundColor: Colors.indigo,
        elevation: 0,
       

      ),
    );
  }
}