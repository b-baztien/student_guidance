import 'package:flutter/material.dart';
import 'package:student_guidance/model/News.dart';
import 'package:student_guidance/model/Teacher.dart';
import 'package:student_guidance/page/News/view_news.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/utils/UIdata.dart';

import 'package:intl/intl.dart';

class CustomCard extends StatefulWidget {
  final Teacher teachers;
  final News news;

  const CustomCard({Key key, this.teachers, this.news}) : super(key: key);
  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  void initState() {
    GetImageService().getImage(widget.news.image).then((url) {
      setState(() {
        widget.news.image = url;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewNewsPage(
                      news: widget.news, teacher: widget.teachers)));
        },
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 4.0,
                  spreadRadius: 5.0,
                  color: Colors.grey.withOpacity(0.1))
            ],
          ),
          child: Stack(
            children: <Widget>[
              Container(
                  height: 250.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white)),
              Container(
                height: 160.0,
                width: 200.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    color: UIdata.themeColor),
              ),
              Padding(
                  padding: EdgeInsets.only(),
                  child: Hero(
                      tag: 'images-${widget.news.topic}',
                      child: Container(
                          height: 160.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(widget.news.image),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0)))))),
              Positioned(
                top: 175.0,
                left: 10,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.news.topic,
                        softWrap: false,
                        style: TextStyle(
                          fontFamily: UIdata.fontFamily,
                          fontSize: 14.0,
                        )),
                    SizedBox(height: 5.0),
                    Text(widget.news.detail,
                        softWrap: false,
                        style: TextStyle(fontSize: 11.0, color: Colors.grey)),
                    SizedBox(height: 5.0),
                    SizedBox(
                      width: 300,
                      child: Divider(
                        height: 1,
                        color: Color(0xff444444).withOpacity(.3),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: 13,
                          color: Colors.grey,
                        ),
                        Text(
                          new DateFormat(' dd MMMM yyyy', 'th_TH')
                              .format(widget.news.startTime.toDate()),
                          style: TextStyle(
                              fontFamily: UIdata.fontFamily,
                              fontSize: 12.0,
                              color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
