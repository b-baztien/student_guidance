import 'package:flutter/material.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/SearchService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class MajorInFaculty extends StatefulWidget {
  final University university;
  final String faculty;

  const MajorInFaculty({Key key, this.university, this.faculty}) : super(key: key);
  
  @override
  _MajorInFacultyState createState() => _MajorInFacultyState();
}

class _MajorInFacultyState extends State<MajorInFaculty> {
  List<Major> listMajor = new  List<Major>();
   @override
  void initState() {
    super.initState();
    SearchService().getListMajor(widget.faculty, widget.university.universityname).then((listUniversityFromService){
      setState(() {
        listMajor = listUniversityFromService;
        print(listUniversityFromService.length);
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
         title: Text('รายชื่อสาขา',
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 20,
            )),
        backgroundColor: UIdata.themeColor,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: listMajor.length,
        itemBuilder: (_,index){
          return ListTile(
            title: Text(listMajor[index].majorName),
          );
        },
      ),
    );
  }
}