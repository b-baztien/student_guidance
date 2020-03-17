import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/page/search-new/itemFaculty-new.dart';
import 'package:student_guidance/service/FacultyService.dart';
import 'package:student_guidance/service/UniversityService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ListUniversityFaculty extends StatefulWidget {
   final String facultys;

  const ListUniversityFaculty({Key key, this.facultys}) : super(key: key);

  @override
  _ListUniversityFacultyState createState() => _ListUniversityFacultyState();
}

class _ListUniversityFacultyState extends State<ListUniversityFaculty> {

  
  final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/faculty-bg.png'),
            fit: BoxFit.cover,
          )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: ShaderMask(
                  shaderCallback: (bound) => RadialGradient(
                          radius: 4.0,
                          colors: [Colors.yellow, Colors.white],
                          center: Alignment.topLeft,
                          tileMode: TileMode.clamp)
                      .createShader(bound),
                  child: Shimmer.fromColors(
                      child: Text(
                       widget.facultys,
                        style: UIdata.textTitleStyle,
                      ),
                      baseColor: Colors.greenAccent,
                      highlightColor: Colors.red,
                      period: const Duration(milliseconds: 3000))),
              leading: ShaderMask(
                  shaderCallback: (bound) => RadialGradient(
                          radius: 5.0,
                          colors: [Colors.greenAccent, Colors.blueAccent],
                          center: Alignment.topLeft,
                          tileMode: TileMode.clamp)
                      .createShader(bound),
                  child: Shimmer.fromColors(
                    child: IconButton(
                      icon: UIdata.backIcon,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    baseColor: Colors.greenAccent,
                    highlightColor: Colors.blueAccent,
                    period: const Duration(milliseconds: 3000),
                  )),
            ),
            body: FutureBuilder<List<DocumentSnapshot>>(
            future: UniversityService()
              .getListUniversityByFacultyName(widget.facultys),
            builder: (context, snapshot) {
            List<DocumentSnapshot> listUniversity = new List();
            if (snapshot.hasData) {
              listUniversity = snapshot.data;
            }
            return Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12, right: 12),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10.0),
                            child: TextField(
                              onChanged: (value) {},
                              controller: _controller,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: UIdata.themeColor,
                                    size: 25.0,
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(left: 10.0, top: 12.0),
                                  hintText: 'ค้นหาชื่อมหาวิทยาลัย',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        _controller.clear();
                                      });
                                    },
                                  )),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    child: Text(
                      'พบทั้งหมด ' +
                          listUniversity.length.toString() +
                          ' มหาวิทยาลัย',
                      style: TextStyle(
                          color: Colors.grey, fontFamily: UIdata.fontFamily),
                    ),
                  ),
                ),
                _buildExpended(listUniversity)
              ],
            );
            }
            ),
          ),
        ),
      ),
    );
  }
Widget _buildExpended(List<DocumentSnapshot> listUniversity,) {
    return Expanded(
      child: ListView.builder(
        itemCount: listUniversity.length,
        itemBuilder: (context, index) {
          return Container(
             decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black.withOpacity(0.5),
                        ),
            child: InkWell(
              onTap: () {
                String uname = new University.fromJson(listUniversity[index].data)
                        .universityname;
                FacultyService().getFacultyByFacNameAndUniRef(widget.facultys, listUniversity[index].reference).then((fa){
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ItemFacultyNew(
                  universityName:uname,
                  docFac: fa.reference,
                  facultys: Faculty.fromJson(fa.data),
                           )));
                });
              },
              child: Container(
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  leading: Container(
                    padding: EdgeInsets.only(right: 5, left: 10),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 2, color:  Colors.white))),
                    child: Icon(Icons.airport_shuttle, color:  Colors.white),
                  ),
                  title: Text(
                    new University.fromJson(listUniversity[index].data)
                        .universityname,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Colors.white, size: 30),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}