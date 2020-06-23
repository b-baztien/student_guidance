import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/StudentFavorite.dart';
import 'package:student_guidance/page/search-new/itemMajor-new.dart';
import 'package:student_guidance/service/MajorService.dart';
import 'package:student_guidance/service/StudentFavoriteService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ListFavorite extends StatefulWidget {
  final Login login;

  const ListFavorite({Key key, this.login}) : super(key: key);

  @override
  _ListFavoriteState createState() => _ListFavoriteState();
}

class _ListFavoriteState extends State<ListFavorite> {
  SharedPreferences pref;
  ProgressDialog _progressDialog;

  @override
  void initState() {
    super.initState();
    _progressDialog =
        UIdata.buildLoadingProgressDialog(context, 'กำลังโหลด...');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/thembg.png'),
              fit: BoxFit.cover,
            )
        ),
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
            padding: const EdgeInsets.only(top: 5.0, right: 8, left: 8),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: StudentFavoriteService()
                      .getStudentFavoriteByUsername(widget.login.username),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<StudentFavorite> list = snapshot.data;
                      return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                setState(() {
                                  _progressDialog.show();
                                });
                                DocumentSnapshot docSnap = await MajorService()
                                    .getMajor(list[index].university,
                                        list[index].faculty, list[index].major);
                                setState(() {
                                  _progressDialog.hide();
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemMajorNew(
                                      universityName: list[index].university,
                                      facultyName: list[index].faculty,
                                      major: docSnap,
                                      listFavorite: snapshot.data,
                                    ),
                                  ),
                                );
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
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/loading.gif',
                              width: 300,
                            ),
                            Text(
                              'กำลังโหลด...',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontFamily: 'Kanit'),
                            )
                          ],
                        ),
                      );
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
