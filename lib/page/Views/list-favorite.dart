import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/StudentFavorite.dart';
import 'package:student_guidance/page/search-new/itemMajor-new.dart';
import 'package:student_guidance/service/FacultyService.dart';
import 'package:student_guidance/service/MajorService.dart';
import 'package:student_guidance/service/StudentFavoriteService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ListFavorite extends StatefulWidget {
  @override
  _ListFavoriteState createState() => _ListFavoriteState();
}

class _ListFavoriteState extends State<ListFavorite> {
  ProgressDialog _progressDialog;
  SharedPreferences pref;
  @override
  Widget build(BuildContext context) {
      _progressDialog = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    _progressDialog.style(message: 'กรุณารอสักครู่....');
    return Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/list-favorite.png"),
                fit: BoxFit.fitHeight)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              UIdata.txListFavorite,
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
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.5),
                  border: Border.all(width: 2, color: Colors.white)),
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: StudentFavoriteService()
                      .getStudentFavoriteByUsername('student'),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<StudentFavorite> list = snapshot.data;
                      return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                             
                              },
                              title: Text(
                                list[index].major,
                                style: UIdata.textTitleStyle,
                              ),
                              subtitle: Text(
                                list[index].university,
                                style: UIdata.textSubTitleStyle,
                              ),
                              trailing: Icon(Icons.keyboard_arrow_right,
                                  color: Colors.white, size: 30),
                            );
                          });
                    } else {
                      return Text('ไม่พบข้อมูล');
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
