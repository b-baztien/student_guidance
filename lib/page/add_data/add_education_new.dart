import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/utils/UIdata.dart';

class AddEducationNew extends StatefulWidget {
  @override
  _AddEducationNewState createState() => _AddEducationNewState();
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

class _AddEducationNewState extends State<AddEducationNew> {
    List<Round> _round = Round.getRound();
  List<DropdownMenuItem<Round>> _dropdownMenuItem;

  Round _selectedRound;
  DocumentReference _selectedUniversity;
  DocumentReference _selectedFaculty;
  DocumentReference _selectedMajor;
  String _schoolName = '';
  @override
  void initState() {
    _dropdownMenuItem = buildDropDownMenuItem(_round);
    UIdata.getPrefs().then((data) {
      _schoolName = data.getString('schoolId');
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
  
  onChangeDropdownItem(Round selectRound) {
    setState(() {
      _selectedRound = selectRound;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/edit-img.png"),
                  fit: BoxFit.fitHeight)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  UIdata.txEducation,
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
                      padding:  const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: <Widget>[
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
}