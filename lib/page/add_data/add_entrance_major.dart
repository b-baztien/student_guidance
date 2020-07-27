import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:student_guidance/model/Alumni.dart';
import 'package:student_guidance/model/EntranceMajor.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/AlumniService.dart';
import 'package:student_guidance/service/EntranService.dart';
import 'package:student_guidance/service/FacultyService.dart';
import 'package:student_guidance/service/MajorService.dart';
import 'package:student_guidance/service/UniversityService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class AddEntranceMajor extends StatefulWidget {
  @override
  _AddEntranceMajorState createState() => _AddEntranceMajorState();
}

class Round {
  String id;
  String name = '';
  Round(this.id, this.name);
  static List<Round> getRound() {
    return <Round>[
      Round('1', 'ศึกษาต่อ'),
      Round('2', 'ประกอบอาชีพ'),
    ];
  }
}

class _AddEntranceMajorState extends State<AddEntranceMajor> {
  final GlobalKey<FormState> _educationKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Round> _round = Round.getRound();
  List<DropdownMenuItem<Round>> _dropdownRoundMenuItem;
  List<DropdownMenuItem<DocumentReference>> _dropdownUniversityMenuItem;
  List<DropdownMenuItem<DocumentReference>> _dropdownFacultyMenuItem;
  List<DropdownMenuItem<DocumentReference>> _dropdownMajorMenuItem;

  Round _selectedRound;
  DocumentReference _selectedUniversity;
  DocumentReference _selectedFaculty;
  DocumentReference _selectedMajor;
  String _schoolName = '';
  Alumni _alumni;
  String _job;
  bool ckOpen;
  ProgressDialog _progressDialog;
  @override
  void initState() {
    ckOpen = true;
    _dropdownRoundMenuItem = buildDropDownMenuItem(_round);
    UIdata.getPrefs().then((data) {
      _schoolName = data.getString('schoolId');
    });

    _selectedUniversity = null;
    _selectedFaculty = null;
    _selectedMajor = null;
    _progressDialog =
        UIdata.buildLoadingProgressDialog(context, 'กำลังเพิ่มข้อมูล...');

    AlumniService().getCurrentAlumni().then((data) {
      _alumni = data;
    });
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

  onChangeRoundDropdownItem(Round selectRound) {
    setState(() {
      ckOpen = false;
      _selectedRound = selectRound;
      _selectedUniversity = null;
      _dropdownFacultyMenuItem = null;
      _dropdownMajorMenuItem = null;
      _selectedFaculty = null;
      _selectedMajor = null;
    });
  }

  onChangeUniversityDropdownItem(DocumentReference selectUniversity) {
    setState(() {
      _selectedUniversity = selectUniversity;
      _dropdownFacultyMenuItem = null;
      _dropdownMajorMenuItem = null;
      _selectedFaculty = null;
      _selectedMajor = null;
    });
  }

  onChangeFacultyDropdownItem(DocumentReference selectFaculty) {
    setState(() {
      _selectedFaculty = selectFaculty;
      _dropdownMajorMenuItem = null;
      _selectedMajor = null;
    });
  }

  onChangeMajorDropdownItem(DocumentReference selectMajor) {
    setState(() {
      _selectedMajor = selectMajor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/thembg.png"),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              UIdata.txEntrance,
              style: UIdata.textTitleStyle,
            ),
            leading: IconButton(
              icon: UIdata.backIcon,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 8, left: 8),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.5),
                  border: Border.all(width: 2, color: Colors.white)),
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
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
                                  'สถานะหลังจบกาศึกษา',
                                  style: TextStyle(
                                      fontFamily: UIdata.fontFamily,
                                      fontSize: 13,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    canvasColor: Colors.black,
                                  ),
                                  child: DropdownButton(
                                    value: _selectedRound,
                                    items: _dropdownRoundMenuItem,
                                    onChanged: onChangeRoundDropdownItem,
                                    style: TextStyle(
                                        decorationColor: Colors.white),
                                    hint: Text('เลือกสถานะ',
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ckOpen == true
                                ? SizedBox(height: 1)
                                : _selectedRound.id == '1'
                                    ? StreamBuilder<List<DocumentSnapshot>>(
                                        stream: UniversityService()
                                            .getAllUniversity(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Container();
                                          } else {
                                            List<
                                                    DropdownMenuItem<
                                                        DocumentReference>>
                                                currencyItem = [];
                                            for (int i = 0;
                                                i < snapshot.data.length;
                                                i++) {
                                              DocumentSnapshot doc =
                                                  snapshot.data[i];
                                              University uni =
                                                  University.fromJson(doc.data);
                                              currencyItem.add(
                                                DropdownMenuItem(
                                                  child: AutoSizeText(
                                                    uni.universityname,
                                                    style: TextStyle(
                                                        decorationColor:
                                                            Colors.white,
                                                        fontSize: 11),
                                                    minFontSize: 8,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  value: doc.reference,
                                                ),
                                              );
                                            }
                                            if (_dropdownUniversityMenuItem ==
                                                null) {
                                              _dropdownUniversityMenuItem =
                                                  currencyItem;
                                            }
                                            return Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'มหาวิทยาลัย',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          UIdata.fontFamily,
                                                      fontSize: 13,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    canvasColor: Colors.black,
                                                  ),
                                                  child: DropdownButton(
                                                    value: _selectedUniversity,
                                                    items:
                                                        _dropdownUniversityMenuItem,
                                                    onChanged:
                                                        onChangeUniversityDropdownItem,
                                                    style: TextStyle(
                                                        decorationColor:
                                                            Colors.white),
                                                    hint: Text(
                                                        'เลือกมหาวิทยาลัย',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          maxLines: 1,
                                          onChanged: (value) {
                                            setState(() {
                                              _job = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'อาชีพที่ทำ',
                                            hintText: 'อาชีพ',
                                            hintStyle: TextStyle(
                                                fontFamily: UIdata.fontFamily,
                                                color: Colors.white,
                                                fontSize: 13),
                                            labelStyle: TextStyle(
                                                fontFamily: UIdata.fontFamily,
                                                color: Colors.white,
                                                fontSize: 13),
                                          ),
                                          style: TextStyle(
                                              fontFamily: UIdata.fontFamily,
                                              color: Colors.white),
                                        ),
                                      ),
                            SizedBox(
                              height: 10,
                            ),
                            StreamBuilder<List<DocumentSnapshot>>(
                              stream: FacultyService().getAllFaculty(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    _selectedUniversity == null) {
                                  return Container();
                                } else {
                                  List<DropdownMenuItem<DocumentReference>>
                                      currencyItem = [];
                                  for (int i = 0;
                                      i < snapshot.data.length;
                                      i++) {
                                    DocumentSnapshot doc = snapshot.data[i];
                                    print(_selectedUniversity);
                                    if (doc.reference
                                            .parent()
                                            .parent()
                                            .documentID ==
                                        _selectedUniversity.documentID) {
                                      Faculty fct = Faculty.fromJson(doc.data);
                                      currencyItem.add(DropdownMenuItem(
                                        child: Text(fct.facultyName),
                                        value: doc.reference,
                                      ));
                                    }
                                  }
                                  if (_dropdownFacultyMenuItem == null) {
                                    _dropdownFacultyMenuItem = currencyItem;
                                  }
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'คณะ',
                                        style: TextStyle(
                                            fontFamily: UIdata.fontFamily,
                                            fontSize: 11,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Theme(
                                        data: Theme.of(context).copyWith(
                                          canvasColor: Colors.black,
                                        ),
                                        child: DropdownButton(
                                          value: _selectedFaculty,
                                          items: _dropdownFacultyMenuItem,
                                          onChanged:
                                              onChangeFacultyDropdownItem,
                                          style: TextStyle(
                                              decorationColor: Colors.white,fontSize: 11),
                                          hint: Text('เลือกคณะ',
                                              style: TextStyle(
                                                color: Colors.white,fontSize: 11
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            StreamBuilder<List<DocumentSnapshot>>(
                              stream: MajorService().getAllMajor(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    _selectedFaculty == null) {
                                  return Container();
                                } else {
                                  List<DropdownMenuItem<DocumentReference>>
                                      currencyItem = [];
                                  for (int i = 0;
                                      i < snapshot.data.length;
                                      i++) {
                                    DocumentSnapshot doc = snapshot.data[i];
                                    if (doc.reference
                                            .parent()
                                            .parent()
                                            .documentID ==
                                        _selectedFaculty.documentID) {
                                      Major major = Major.fromJson(doc.data);
                                      currencyItem.add(DropdownMenuItem(
                                        child: Text(major.majorName),
                                        value: doc.reference,
                                      ));
                                    }
                                  }
                                  if (_dropdownMajorMenuItem == null) {
                                    _dropdownMajorMenuItem = currencyItem;
                                  }
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'สาขา',
                                        style: TextStyle(
                                            fontFamily: UIdata.fontFamily,
                                            fontSize: 13,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Theme(
                                        data: Theme.of(context).copyWith(
                                          canvasColor: Colors.black,
                                        ),
                                        child: DropdownButton(
                                          value: _selectedMajor,
                                          items: _dropdownMajorMenuItem,
                                          onChanged: onChangeMajorDropdownItem,
                                          style: TextStyle(
                                              decorationColor: Colors.white),
                                          hint: Text('เลือกสาขา',
                                              style: TextStyle(
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
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
                                    _selectedRound.id == '1'
                                        ? addDataInStudyStatus()
                                        : addDataInCareerStatus();
                                  }),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  addDataInStudyStatus() async {
    try {
      _progressDialog.show();
      EntranceMajor enMajor = EntranceMajor();
      _alumni.status = _selectedRound.name;
      _alumni.job = 'นักศึกษา';
      enMajor.universityName =
          University.fromJson(((await _selectedUniversity.get()).data))
              .universityname;
      enMajor.facultyName =
          Faculty.fromJson((await _selectedFaculty.get()).data).facultyName;
      enMajor.majorName =
          Major.fromJson((await _selectedMajor.get()).data).majorName;
      enMajor.schoolName = _schoolName;
      enMajor.entranceYear = _alumni.graduateYear;
      EntranService().addEntranceMajor(enMajor).then((result) {
        _progressDialog.hide();
        if (result) {
          Navigator.pop(context, 'เพิ่มข้อมูลสำเร็จ');
        } else {
          _progressDialog.hide();
          _scaffoldKey.currentState
              .showSnackBar(UIdata.dangerSnackBar('เพิ่มข้อมูลล้มเหลว'));
        }
      });
    } catch (e) {
      _progressDialog.hide();
      _scaffoldKey.currentState
          .showSnackBar(UIdata.dangerSnackBar('เพิ่มข้อมูลล้มเหลว'));
    }
  }

  addDataInCareerStatus() {
    try {
      _progressDialog.show();
      _alumni.status = _selectedRound.name;
      _alumni.job = _job;
      AlumniService().addEditStudentRecommend(_alumni).then((result) {
        _progressDialog.hide();
        if (result) {
          Navigator.pop(context, 'เพิ่มข้อมูลสำเร็จ');
        } else {
          _progressDialog.hide();
          _scaffoldKey.currentState
              .showSnackBar(UIdata.dangerSnackBar('เพิ่มข้อมูลล้มเหลว'));
        }
      });
    } catch (e) {
      _progressDialog.hide();
      _scaffoldKey.currentState
          .showSnackBar(UIdata.dangerSnackBar('เพิ่มข้อมูลล้มเหลว'));
    }
  }
}
