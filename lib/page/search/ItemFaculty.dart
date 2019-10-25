import 'package:flutter/material.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/SearchService.dart';

class ItemFaculty extends StatefulWidget {
  final String facultyName;

  const ItemFaculty({Key key, this.facultyName}) : super(key: key);
  @override
  _ItemFacultyState createState() => _ItemFacultyState();
}

class _ItemFacultyState extends State<ItemFaculty> {
  List<University> listUniversity = new  List<University>();
   @override
  void initState() {
    super.initState();
    SearchService().getListUniversity(widget.facultyName).then((listUniversityFromService){
      setState(() {
        listUniversity = listUniversityFromService;
        print(listUniversityFromService.length);
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}