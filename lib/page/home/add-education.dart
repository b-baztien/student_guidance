import 'package:flutter/material.dart';

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  String _selectedUniversity;
  String _selectedFaculty;
  String _selectedMajor;
  String _selectRound;
  List<String> _university = [
    'มหาวิทยาลัยแม่โจ้',
    'มหาวิทยาลัยเชียงใหม่',
    'มหาวิทยาลัยพะเยา',
    'มหาวิทยาลัยกรุงเทพ'
  ];
  List<String> _falcuty = ['วิทยาศาสตร์', 'เกษตรศาสตร์'];
  List<String> _major = ['เทคโนโลยีสารสนเทศ', 'เคมี'];
   List<String> _round = ['1', '2','3','4','5','อื่นๆ'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      contentPadding: EdgeInsets.all(5),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[
          
          TextField(
            decoration: InputDecoration(
                hintText: 'กรอกปีการศึกษา'),style: TextStyle(fontFamily: 'Kanit',fontSize: 13),
          ),
           TextField(
            decoration: InputDecoration(
                hintText: 'ชื่อรายการสอบ'),style: TextStyle(fontFamily: 'Kanit',fontSize: 13),
          ),
          DropdownButtonFormField<String>(
            items: _round
                .map((_round) => DropdownMenuItem(
                      child: Text(_round),
                      value: _round,
                    ))
                .toList(),
            hint: Text('เลือก รอบการสอบ',style: TextStyle(fontFamily: 'Kanit',fontSize: 13),),
            onChanged: (value) {
              setState(() {
                this._selectRound = value;
              });
              print(_selectRound);
            },
            value: _selectRound,
          ),
          DropdownButtonFormField<String>(
            items: _university
                .map((label) => DropdownMenuItem(
                      child: Text(label),
                      value: label,
                    ))
                .toList(),
            hint: Text('เลือก มหาวิทยาลัย',style: TextStyle(fontFamily: 'Kanit',fontSize: 13),),
            onChanged: (value) {
              setState(() {
                this._selectedUniversity = value;
              });
              print(_selectedUniversity);
            },
            value: _selectedUniversity,
          ),
          DropdownButtonFormField<String>(
            items: _falcuty
                .map((falcuty) => DropdownMenuItem(
                      child: Text(falcuty),
                      value: falcuty,
                    ))
                .toList(),
            hint: Text('เลือก คณะ',style: TextStyle(fontFamily: 'Kanit',fontSize: 13),),
            onChanged: (value) {
              setState(() {
                this._selectedFaculty = value;
              });
              print(_selectedFaculty);
            },
            value: _selectedFaculty,
          ),
          DropdownButtonFormField<String>(
            items: _major
                .map((major) => DropdownMenuItem(
                      child: Text(major),
                      value: major,
                    ))
                .toList(),
            hint: Text('เลือก สาขา',style: TextStyle(fontFamily: 'Kanit',fontSize: 13),),
            onChanged: (value) {
              setState(() {
                this._selectedMajor = value;
              });
              print(_selectedMajor);
            },
            value: _selectedMajor,
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        )
      ],
    );
  }
}
