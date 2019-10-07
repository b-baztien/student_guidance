import 'package:flutter/material.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/service/FacultyService.dart';

class SearchFaculty extends StatefulWidget {
  @override
  _SearchFacultyState createState() => _SearchFacultyState();
}

class _SearchFacultyState extends State<SearchFaculty> {
  final TextEditingController _controller = new TextEditingController();

   List<Faculty> items = List<Faculty>();
 List<Faculty> faculty;
  @override
  void initState(){
     super.initState();
   FacultyService().getAllFaculty().then((facultyFromService){
    setState(() {
      faculty = facultyFromService;
      items = faculty;
    });
  }); 
  }

  @override
  Widget build(BuildContext context) {
     final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
       resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
                    height: screenHeight,
                    color: Colors.transparent,
                    child: ListView.builder(
                      itemCount: items.length,
                     itemBuilder: (_,i) => listFacultys(ff: items[i],),
                    ),
                   
      )
      
    );
  }
}

class listFacultys extends StatelessWidget {
  final Faculty ff;
  const listFacultys({Key key, this.ff}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print(ff.facultyName);
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.all(6),
          padding: EdgeInsets.all(6),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                child: Text(ff.facultyName[0]),
                backgroundColor: Color(0xFF20D3D2),
                foregroundColor: Colors.black87,
              ),
              Padding(
                padding: EdgeInsets.all(8),
              ),
              Text(ff.facultyName),
            ],
          ),
        ),
      ),
    );
  }
  
}
