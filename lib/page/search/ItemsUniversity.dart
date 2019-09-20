import 'package:flutter/material.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/UniversityService.dart';

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