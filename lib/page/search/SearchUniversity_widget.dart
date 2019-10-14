import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/UniversityService.dart';
import 'package:student_guidance/service/getImageService.dart';

import 'ItemsUniversity.dart';

class SearchUniversityWidget extends StatefulWidget {
  SearchUniversityWidget() : super();
  @override
  _SearchUniversityWidgetState createState() => _SearchUniversityWidgetState();
}

class _SearchUniversityWidgetState extends State<SearchUniversityWidget>
    with SingleTickerProviderStateMixin {
  List<University> items = List<University>();
  List<University> ulist = List<University>();
  List<University> university;
  final TextEditingController _controller = new TextEditingController();
  @override
  void initState() {
    super.initState();
    UniversityService().getUniversity().then((universityFomService) {
      setState(() {
        university = universityFomService;
        items = university;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            items = university
                                .where((u) => (u.universityname
                                    .toLowerCase()
                                    .contains(value.toLowerCase())))
                                .toList();
                          });
                        },
                        controller: _controller,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.pinkAccent,
                              size: 25.0,
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 10.0, top: 12.0),
                            hintText: 'ค้นหามหาวิทยาลัย',
                            hintStyle: TextStyle(color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _controller.clear();
                                  items = university;
                                });
                              },
                            )),
                      ),
                    ),
                  )
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
                'พบทั้งหมด ' + items.length.toString() + ' มหาวิทยาลัย',
                style: TextStyle(color: Colors.indigo, fontFamily: 'kanit'),
              ),
            ),
          ),
          _buildExpended()
        ],
      ),
    );
  }

  Widget _buildExpended() {
    return Expanded(
        child: ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.all(5),
            child: InkWell(
              onTap: () {
                UniversityService()
                    .updateView(items[index].universityname, items[index].view);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ItemUniversity(universitys: items[index])));
                print(items[index].universityname);
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 46),
                    height: 124,
                    width: 350,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors
                              .blue[500], //                   <--- border color
                          width: 3.0,
                        ),
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: <BoxShadow>[
                          new BoxShadow(
                              color: Colors.black12,
                              offset: new Offset(0.0, 10.0),
                              blurRadius: 10)
                        ]),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 50),
                              child: Text(
                                items[index].universityname,
                                style: TextStyle(
                                    fontFamily: 'kanit',
                                    fontSize: 20,
                                    color: Colors.blue[500]),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Hero(
                    tag: items[index].image,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      alignment: FractionalOffset.centerLeft,
                      child: Image(
                        image: NetworkImage(items[index].image),
                        height: 92,
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
    ));
  }
}
