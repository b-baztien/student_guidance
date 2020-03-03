import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/model/EntranceExamResult.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/EntranService.dart';
import 'package:student_guidance/service/FacultyService.dart';
import 'package:student_guidance/service/MajorService.dart';
import 'package:student_guidance/service/StudentService.dart';
import 'package:student_guidance/service/UniversityService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class AddEducation extends StatefulWidget {
  @override
  _AddEducationState createState() => _AddEducationState();
}

class Round {
  String id;
  String name = '';
  Round(this.id, this.name);
  static List<Round> getRound() {
    return <Round>[
      Round('1', 'Portfolio'),
      Round('2', 'การรับแบบโควตา'),
      Round('3', 'รับตรงร่วมกัน (+กสพท)'),
      Round('4', 'การรับแบบแอดมิชชัน'),
      Round('5', 'การรับตรงอิสระ'),
    ];
  }
}

class _AddEducationState extends State<AddEducation> {
  List<Round> _round = Round.getRound();
  List<DropdownMenuItem<Round>> _dropdownMenuItem;

  Round _selectedRound;
  DocumentReference _selectedUniversity;
  DocumentReference _selectedFaculty;
  DocumentReference _selectedMajor;

  @override
  void initState() {
    _dropdownMenuItem = buildDropDownMenuItem(_round);

    super.initState();
  }

  List<DropdownMenuItem<Round>> buildDropDownMenuItem(List rounded) {
    List<DropdownMenuItem<Round>> items = List();
    for (Round round in rounded) {
      items.add(
        DropdownMenuItem(
          value: round,
          child: Text(round.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Round selectRound) {
    setState(() {
      _selectedRound = selectRound;
    });
  }

  final GlobalKey<FormState> _educationKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIdata.themeColor,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 100,
          ),
          Padding(
            padding: EdgeInsets.only(left: 40),
            child: Row(
              children: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.school,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'เพิ่มข้อมูลการสอบติด',
                  style: TextStyle(
                      fontFamily: UIdata.fontFamily,
                      color: Colors.white,
                      fontSize: 25),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 185,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(75),
              ),
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  Form(
                    key: _educationKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'รอบการสมัคร',
                              style: TextStyle(
                                  fontFamily: UIdata.fontFamily,
                                  fontSize: 18,
                                  color: Colors.black45),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            DropdownButton(
                              value: _selectedRound,
                              items: _dropdownMenuItem,
                              onChanged: onChangeDropdownItem,
                              hint: Text('เลือกรอบการสอบ'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<List<DocumentSnapshot>>(
                          stream: UniversityService().getAllUniversity(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              List<DropdownMenuItem> currencyItem = [];
                              for (int i = 0; i < snapshot.data.length; i++) {
                                DocumentSnapshot doc = snapshot.data[i];
                                University uni = University.fromJson(doc.data);
                                currencyItem.add(
                                  DropdownMenuItem(
                                    child: Text(uni.universityname),
                                    value: doc.reference,
                                  ),
                                );
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'มหาวิทยาลัย',
                                    style: TextStyle(
                                        fontFamily: UIdata.fontFamily,
                                        fontSize: 18,
                                        color: Colors.black45),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  DropdownButton(
                                    items: currencyItem,
                                    onChanged: (values) {
                                      setState(() {
                                        _selectedUniversity = values;
                                        _selectedFaculty = null;
                                        _selectedMajor = null;
                                      });
                                    },
                                    value: _selectedUniversity,
                                    hint: Text('เลือกมหาวิทยาลัย'),
                                  )
                                ],
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<List<DocumentSnapshot>>(
                          stream: FacultyService().getAllFaculty(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              List<DropdownMenuItem> currencyItem = [];
                              for (int i = 0; i < snapshot.data.length; i++) {
                                DocumentSnapshot doc = snapshot.data[i];
                                if (doc.reference.parent().parent() ==
                                    _selectedUniversity) {
                                  Faculty fct = Faculty.fromJson(doc.data);
                                  currencyItem.add(DropdownMenuItem(
                                    child: Text(fct.facultyName),
                                    value: doc.reference,
                                  ));
                                }
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'คณะ',
                                    style: TextStyle(
                                        fontFamily: UIdata.fontFamily,
                                        fontSize: 18,
                                        color: Colors.black45),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  DropdownButton(
                                    items: currencyItem,
                                    onChanged: (values) {
                                      setState(() {
                                        _selectedFaculty = values;
                                        _selectedMajor = null;
                                      });
                                    },
                                    value: _selectedFaculty,
                                    hint: Text('เลือกคณะ'),
                                  )
                                ],
                              );
                            }
                          },
                        ),
                        StreamBuilder<List<DocumentSnapshot>>(
                          stream: MajorService().getAllMajor(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                  width: 100.0, child: Text('data'));
                            } else {
                              List<DropdownMenuItem> currencyItem = [];
                              for (int i = 0; i < snapshot.data.length; i++) {
                                DocumentSnapshot doc = snapshot.data[i];
                                if (doc.reference.parent().parent() ==
                                    _selectedFaculty) {
                                  Major major = Major.fromJson(doc.data);
                                  currencyItem.add(DropdownMenuItem(
                                    child: Text(major.majorName),
                                    value: doc.reference,
                                  ));
                                }
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'สาขา',
                                    style: TextStyle(
                                        fontFamily: UIdata.fontFamily,
                                        fontSize: 18,
                                        color: Colors.black45),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  DropdownButton(
                                    items: currencyItem,
                                    onChanged: (values) {
                                      setState(() {
                                        _selectedMajor = values;
                                      });
                                    },
                                    value: _selectedMajor,
                                    hint: Text('เลือกสาขา'),
                                  )
                                ],
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 30.0),
                          width: double.infinity,
                          child: RaisedButton(
                            padding: EdgeInsets.all(15.0),
                            shape: StadiumBorder(),
                            child: Text(
                              'เพิ่มข้อมูล',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: UIdata.themeColor,
                            onPressed: () async {
                              EntranceExamResult enExam = EntranceExamResult();
                              enExam.entranceExamName = _selectedRound.name;
                              enExam.round = _selectedRound.id;
                              enExam.university = University.fromJson(
                                      ((await _selectedUniversity.get()).data))
                                  .universityname;
                              enExam.faculty = Faculty.fromJson(
                                      (await _selectedFaculty.get()).data)
                                  .facultyName;
                              enExam.major = Major.fromJson(
                                      (await _selectedMajor.get()).data)
                                  .majorName;
                              enExam.year =
                                  (DateTime.now().toLocal().year).toString();
                              EntranService().addEntranceExamResult(enExam);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
