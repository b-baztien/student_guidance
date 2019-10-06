import 'package:flutter/material.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ViewNewsPage extends StatefulWidget {
  final news;
  final teacher;
  ViewNewsPage({this.news, this.teacher});

  @override
  _ViewNewsPage createState() => _ViewNewsPage();
}

class _ViewNewsPage extends State<ViewNewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: UIdata.backIcon,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Hero(
                tag: 'images-${widget.news.topic}',
                child: Container(
                  height: 350.0,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(50)),
                      image: DecorationImage(
                          image: new NetworkImage(widget.news.image),
                          fit: BoxFit.fill)),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('วันที่ : 13/09/2019',
                              style: TextStyle(
                                  fontFamily: 'kanit',
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                         
                        ],
                      ),
                    ],
                  ),
                   Container(
                            child: Text(widget.news.topic,
                                style: TextStyle(
                                  fontFamily: 'kanit',
                                  fontSize: 20,
                                )),
                          ),
                  SizedBox(height: 10.0),
                  Container(
                    child: Text(
                        "โพสโดย ครู" +
                            widget.teacher.firstname +
                            "  " +
                            widget.teacher.lastname,
                        style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    child: Text(widget.news.detail,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black.withOpacity(0.7))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
