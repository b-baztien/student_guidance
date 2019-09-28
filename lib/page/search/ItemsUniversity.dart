import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/FacultyService.dart';
import 'package:student_guidance/service/UniversityService.dart';
import 'package:student_guidance/utils/UIdata.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class ItemUniversity extends StatefulWidget {
  final University universitys;

  const ItemUniversity({Key key, this.universitys}) : super(key: key);
  @override
  _ItemUniversityState createState() => _ItemUniversityState();
}

class _ItemUniversityState extends State<ItemUniversity> {
  List<DocumentReference> faculty;
  
  List<Faculty> items;
 @override
  void initState(){

  FacultyService().getFacultyList(faculty).then((facultyFomService){
    setState(() {
      items = facultyFomService;
    });
  });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 420.0,
            color: Color(0xFF20D3D2),

          ),
          Positioned(
            left: screenWidth / 2 + 25.0,
            bottom: screenHeight - 275.0,
            child: Hero(
              tag: widget.universitys.image,
              child: Container(
                height: 150.0,
                width: 150.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.universitys.image),
                        fit: BoxFit.fill)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Positioned(
            top: 200,
            right: -160,
            child: Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              width: screenWidth,
              child: IconButton(
                icon: Icon(Icons.favorite),
                color: Colors.pink[300],
                iconSize: 60,
                onPressed: (){
                  print('click favorite');
                },
              ),
            ),
          ),
          Positioned(
            top: 200,
            child: Container(
              height: screenHeight- 190,
              width: screenWidth,
               decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(240))),
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                      top: 5.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Container(
                        width: screenWidth - 40.0,
                        child:  Text(
                          widget.universitys.universityname,
                          style: TextStyle(
                              fontFamily: 'kanit',
                              fontWeight: FontWeight.w900,
                              fontSize: 22.0),
                        ),
                      )
                        ),
                          Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 10.0, top: 5.0),
                  child: Text(
                    'มีคนในโรงเรียนไปศึกษาต่อจำนวน',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: Color(0xFFBBBBBB)),
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 10.0, top: 5.0),
                  child: Text(
                    'รายชื่อคณะ',
                    style: TextStyle(
                      fontFamily: 'kanit',
                      fontWeight: FontWeight.w900,
                      fontSize: 16.0,
                    ),
                  ),
                ),
               

                      ],
                    ),
            ),
            
          )
        ],
      ),
    );
  }
}
