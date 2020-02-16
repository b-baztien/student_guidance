import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/FacultyService.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:photo_view/photo_view.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ItemUniversity extends StatefulWidget {
  final DocumentSnapshot universitys;

  const ItemUniversity({Key key, this.universitys}) : super(key: key);
  @override
  _ItemUniversityState createState() => _ItemUniversityState();
}

class _ItemUniversityState extends State<ItemUniversity> {
  University _university = new University();
  String facId = '';
  List<DocumentReference> listFacultyDocumentReference =
      new List<DocumentReference>();
  List<Faculty> listFaculty = new List<Faculty>();
  List<Faculty> items;
  String emptyFacText = 'ไม่พบคณะในมหาวิทยาลัย';

  @override
  void initState() {
    _university = University.fromJson(widget.universitys.data);
    facId = widget.universitys.documentID;
    if (facId.length != 0) {
      FacultyService()
          .getFacultyByUniversityId(facId)
          .then((facultyFromService) {
        for (Faculty fac in facultyFromService) {
          GetImageService().getImage(_university.image).then((url) {
            GetImageService()
                .getListImage(_university.albumImage)
                .then((listUrl) {
              setState(() {
                print("1" + listUrl.length.toString());
                _university.albumImage = listUrl;

                _university.image = url;
                listFaculty.add(fac);
              });
            });
          });
        }
      });
      emptyFacText = '';
    } else {
      GetImageService().getImage(_university.image).then((url) {
        GetImageService().getListImage(_university.albumImage).then((listUrl) {
          setState(() {
            _university.albumImage = listUrl;
            print("2" + listUrl.length.toString());
            _university.image = url;
          });
        });
      });
      emptyFacText = 'ไม่พบคณะในมหาวิทยาลัย';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: 420.0,
              color: UIdata.themeColor,
            ),
            Positioned(
              left: screenWidth / 2 + 25.0,
              bottom: screenHeight - 200.0,
              child: Hero(
                tag: _university.image,
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(_university.image),
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
                width: screenWidth,
                height: screenHeight - 200,
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
                            _university.universityname,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontFamily: UIdata.fontFamily,
                                fontWeight: FontWeight.w200,
                                fontSize: 22.0),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10.0),
                        child: Container(
                          width: screenWidth - 40.0,
                          child: Text(
                            "ภาค" + _university.zone,
                            style: TextStyle(
                                fontFamily: UIdata.fontFamily,
                                color: Colors.grey,
                                fontSize: 15.0),
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
                                      fontFamily: UIdata.fontFamily,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                      color: UIdata.themeColor),
                                ),
                                Text(
                                  'เรียนต่อ',
                                  style: TextStyle(
                                      fontFamily: UIdata.fontFamily,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                      color: Colors.black87),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  '0',
                                  style: TextStyle(
                                      fontFamily: UIdata.fontFamily,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                      color: Colors.pink),
                                ),
                                Text(
                                  'ผู้ติดตาม',
                                  style: TextStyle(
                                      fontFamily: UIdata.fontFamily,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                      color: Colors.black87),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  _university.view.toString(),
                                  style: TextStyle(
                                      fontFamily: UIdata.fontFamily,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                      color: Colors.green),
                                ),
                                Text(
                                  'ผู้เข้าชม',
                                  style: TextStyle(
                                      fontFamily: UIdata.fontFamily,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                      color: Colors.black87),
                                )
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10.0, top: 5.0),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                print('ติดตาม');
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: UIdata.themeColor),
                                child: Text(
                                  'ติดตาม',
                                  style: TextStyle(
                                      fontFamily: UIdata.fontFamily,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,

                                    builder: (context) {
                                      return Container(
                                        height: 180,
                                        child: _buildBottomNavigationMenu(
                                            _university),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: const Radius.circular(30),
                                            topRight: const Radius.circular(30),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.green),
                                child: Text(
                                  'ติดต่อ',
                                  style: TextStyle(
                                      fontFamily: UIdata.fontFamily,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0, top: 5.0),
                      child: Container(
                        width: screenWidth - 40.0,
                        child: Text(
                          'รายชื่อคณะ ' +
                              (listFaculty.length != 0
                                  ? '(${listFaculty.length}) '
                                  : ''),
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontFamily: UIdata.fontFamily,
                            fontWeight: FontWeight.w300,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      height: screenHeight - 520,
                      color: Colors.transparent,
                      // child ListView
                      child: listFaculty.length == 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.search,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                Text(
                                  emptyFacText,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: UIdata.fontFamily,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              itemCount: listFaculty.length,
                              itemBuilder: (_, i) => ListFacultys(
                                    ff: listFaculty[i],
                                  )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListFacultys extends StatelessWidget {
  final Faculty ff;
  const ListFacultys({Key key, this.ff}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(ff.facultyName);
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.all(6),
          padding: EdgeInsets.all(6),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                child: Text(
                  ff.facultyName[0],
                  style: TextStyle(color: UIdata.fontColor),
                ),
                backgroundColor: UIdata.themeColor,
              ),
              Padding(
                padding: EdgeInsets.all(8),
              ),
              Text(
                ff.facultyName,
                style: TextStyle(color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Column _buildBottomNavigationMenu(University university) {
  return Column(
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.phone),
        title: Text(university.phoneNO),
      ),
      ListTile(
        leading: Icon(Icons.http),
        title: Text(university.url),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text(university.address +
            " " +
            university.tambon +
            " " +
            university.amphur +
            " " +
            university.province +
            " " +
            university.zipcode),
      )
    ],
  );
}
