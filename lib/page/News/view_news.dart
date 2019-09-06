import 'package:flutter/material.dart';
import 'package:student_guidance/model/News.dart';

class ViewNewsPage extends StatelessWidget {
  ViewNewsPage({@required this.news});
  final News news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(news.topic),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/studying.png'),
                Text(news.detail),
               
              ]),
        ));
  }
}
