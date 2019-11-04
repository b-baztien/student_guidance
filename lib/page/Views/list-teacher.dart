import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/model/School.dart';
import 'package:student_guidance/model/Teacher.dart';
import 'package:student_guidance/service/SchoolService.dart';
import 'package:student_guidance/service/StudentService.dart';
import 'package:student_guidance/service/TeacherService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ListTeacher extends StatefulWidget {
  @override
  _ListTeacherState createState() => _ListTeacherState();
}

class _ListTeacherState extends State<ListTeacher> {
   String shcool_name = '';
   School school = new School();
   List<Teacher> listTeacher = new List<Teacher>();
    @override
  void initState() {
    super.initState();
    StudentService().getStudent().then((studentFromService) {
      SchoolService()
          .getSchool(studentFromService.school)
          .then((schoolFromService) {
            TeacherService().getAllTeacher().then((list){
 setState(() {
   listTeacher = list;
          school = schoolFromService;
          shcool_name = schoolFromService.schoolName;
        });
            });
       
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
   
      body:SafeArea(
        child: ListView(
          children: <Widget>[
Container(
                height: 120,
                decoration: BoxDecoration(
                  color: UIdata.themeColor,
                ),
                child: Column(
                  children: <Widget>[
                      SizedBox(height: 30.0),
                     Text(
                'รายชื่อคุณครู',
                style: TextStyle(
                    color: UIdata.fontColor,
                    fontFamily: 'Kanit',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
                Text(
                shcool_name,
                style: TextStyle(
                    color: UIdata.fontColor,
                    fontFamily: 'Kanit',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
                  ],
                ),
                
              ),
               Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height:  MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: listTeacher.length,
                itemBuilder: (context,i){
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(listTeacher[i].image),
                        
                        ),
                    
                    title: Text(
                      listTeacher[i].firstname+" "+listTeacher[i].lastname,
                      style: TextStyle(
                          color: UIdata.themeColor,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(listTeacher[i].email),

                    trailing: Text("เบอร์โทรศัพท์ "+listTeacher[i].phoneNO)
                  );
                },
              ),
              )
              ),

          ],
        ),
      )
      
    );
  }
}