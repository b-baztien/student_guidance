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
  List<dynamic> listFacultyDynamic;
  List<DocumentReference> listFacultyDocumentReference =
      new List<DocumentReference>();
  List<Faculty> listFaculty = new List<Faculty>();
  List<Faculty> items;
  String text;

  @override
  void initState() {
    listFacultyDynamic = widget.universitys.faculty;
    if (listFacultyDynamic.length != 0) {
      for (DocumentReference docRef in listFacultyDynamic) {
        FacultyService().getFaculty(docRef).then((facultyFromService) {
          setState(() {
            listFaculty.add(facultyFromService);
          });
        });
      }
      text = '';
    } else {
      text = 'ไม่พบคณะในมหาวิทยาลัย';
    }

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
            child: Container(
              height: screenHeight - 190,
              width: screenWidth,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(240))),
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: 15.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Container(
                        width: screenWidth - 40.0,
                        child: Text(
                          widget.universitys.universityname,
                          style: TextStyle(
                              fontFamily: 'kanit',
                              fontWeight: FontWeight.w900,
                              fontSize: 22.0),
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 10.0, top: 5.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                              Text(
                          '0',
                          style: TextStyle(
                              fontFamily: 'kanit',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color:  Colors.blueAccent),
                        ),
                             Text(
                          'เรียนต่อ',
                          style: TextStyle(
                              fontFamily: 'kanit',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color:  Colors.black87),
                        )
                          ],
                        ),
                        SizedBox(width: 50,),
                         Column(
                          children: <Widget>[
                              Text(
                          '0',
                          style: TextStyle(
                              fontFamily: 'kanit',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color:  Colors.pink),
                        ),
                             Text(
                          'ผู้ติดตาม',
                          style: TextStyle(
                              fontFamily: 'kanit',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color:  Colors.black87),
                        )
                          ],
                        ),
                          SizedBox(width: 50,),
                         Column(
                          children: <Widget>[
                              Text(
                          widget.universitys.view.toString(),
                          style: TextStyle(
                              fontFamily: 'kanit',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color:  Colors.green),
                        ),
                             Text(
                          'ผู้เข้าชม',
                          style: TextStyle(
                              fontFamily: 'kanit',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color:  Colors.black87),
                        )
                          ],
                        ),
                       
                      ],
                    )
                  ),
                 
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 10.0, top: 5.0),
                    child: Row(
                      children: <Widget>[
                       InkWell(
                         onTap: (){
                           print('ติดตาม');
                         },
                         child: Container(
                           alignment: Alignment.center,
                           height: 40,
                           width: 100,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(8),
                             color: Colors.blueAccent
                           ),
                           child:  Text(
                          'ติดตาม',
                          style: TextStyle(
                              fontFamily: 'kanit',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color:  Colors.white),
                        ),
                         ),
                       ),
                       SizedBox(width: 20,),
                         InkWell(
                            onTap: (){
                              showModalBottomSheet(context: context,
                              builder: (context){
                                return Container(
                               height: 180,
                               child: _buildBottomNavigationMenu(widget.universitys.phoneNO,widget.universitys.url,widget.universitys.address),
                                  decoration: BoxDecoration(
                                 
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(30),
                                      topRight: const Radius.circular(30),
                                    ),
                                 
                                  ),
                                );
                              }
                              );
                          
                         },
                         child: Container(
                           alignment: Alignment.center,
                           height: 40,
                           width: 100,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(8),
                             color: Colors.green
                           ),
                           child:  Text(
                          'ติดต่อ',
                          style: TextStyle(
                              fontFamily: 'kanit',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color:  Colors.white),
                        ),
                         ),
                       )
                      ],
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 10.0, top: 5.0),
                    child: Container(
                        width: screenWidth - 40.0,
                        child: listFaculty.length !=0 ?
                        Text(
                          'รายชื่อคณะ (${listFaculty.length}) ',
                          style: TextStyle(
                            fontFamily: 'kanit',
                            fontWeight: FontWeight.w900,
                            fontSize: 16.0,
                          ),
                        )
                        :
                        Text(
                          'รายชื่อคณะ',
                          style: TextStyle(
                            fontFamily: 'kanit',
                            fontWeight: FontWeight.w900,
                            fontSize: 16.0,
                          ),
                        )
                        ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    height: screenHeight,
                    color: Colors.transparent,
                    // child ListView
                    child: listFaculty.length == 0
                        ? Text(text)
                        : ListView.builder(
                            itemCount: listFaculty.length,
                            itemBuilder: (_, i) => listFacultys(
                                  ff: listFaculty[i],
                                )),
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

Column _buildBottomNavigationMenu(String phone,String email,String address){
  return Column(
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.phone),
        title:Text(phone),
      ),
      ListTile(
        leading: Icon(Icons.http),
        title:Text(email),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title:Text(address),
      )
    ],
  );
  }