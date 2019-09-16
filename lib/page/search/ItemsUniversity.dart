import 'package:flutter/material.dart';
import 'package:student_guidance/model/University.dart';

class ItemsUniversity extends StatelessWidget {
  final String universitys;

  const ItemsUniversity({Key key, this.universitys}) : super(key: key);

  

 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Text(universitys),
      
    );
  }
}