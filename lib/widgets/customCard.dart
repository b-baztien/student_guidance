import 'package:flutter/material.dart';
import 'package:student_guidance/model/News.dart';
import 'package:student_guidance/page/News/view_news.dart';


class CustomCard extends StatelessWidget {
  CustomCard({@required this.news});

  final News news;
  

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              children: <Widget>[
                Text(news.topic),
                
                FlatButton(
                    child: Text("ดูรายละเอียดเพิ่มเติม"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewNewsPage(
                                  news: news)));
                    }),
              ],
            )));
  }
}