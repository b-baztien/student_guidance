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

  Future<List<Teacher>> listFutureTeacher =
      StudentService().getStudent().then((studentFromService) {
    return SchoolService()
        .getSchool(studentFromService.school)
        .then((schoolFromService) {
      return TeacherService().getAllTeacher();
    });
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          backgroundColor: UIdata.themeColor,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text("รายชื่อคุณครู",
                style: TextStyle(
                  color: UIdata.fontColor,
                  fontSize: 20.0,
                )),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: listFutureTeacher,
            builder: (_, snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Container(
                    width: 100.0,
                    child: FlareActor(
                      "assets/animates/Water_Melon.flr",
                      animation: 'falling seed',
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                    ),
                  );
                default:
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        leading: CircleAvatar(
                          foregroundColor: UIdata.themeColor,
                          backgroundImage: NetworkImage(snapshot.data[i].image),
                        ),
                        title: Text(
                          snapshot.data[i].firstname +
                              " " +
                              snapshot.data[i].lastname,
                          style: TextStyle(
                              color: UIdata.themeColor,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(snapshot.data[i].email),
                        trailing:
                            Text("เบอร์โทรศัพท์ " + snapshot.data[i].phoneNO),
                      );
                    },
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
