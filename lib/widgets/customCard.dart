import 'package:flutter/material.dart';
import 'package:student_guidance/model/News.dart';
import 'package:student_guidance/model/Teacher.dart';
import 'package:student_guidance/page/News/view_news.dart';


class CustomCard extends StatelessWidget {
 
  final Teacher teachers;
  final News news;
  const CustomCard({Key key, this.teachers, this.news}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.all(10.0),
       child: InkWell(
         onTap: (){
             Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewNewsPage(
                                  news: news,teacher:teachers)));
         },
         child: Container(
           width: 200,
           decoration: BoxDecoration(
             borderRadius:  BorderRadius.circular(10.0),
             boxShadow: [
                BoxShadow(
                          blurRadius: 4.0,
                          spreadRadius: 5.0,
                          color: Colors.grey.withOpacity(0.1))
             ]),
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
                          color: Colors.blue),
                    ),
                     Padding(
                        padding: EdgeInsets.only(),
                        child: Hero(
                            tag: 'images-${news.topic}',
                            child: Container(
                                height: 160.0,
                                width: 200.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:new NetworkImage(news.image),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0)))))),
                                        Positioned(
                                          top: 175.0,
                                          left: 10,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                               Text(news.topic,
                                style: TextStyle(
                                  fontFamily: 'AbrilFatFace',
                                  fontSize: 14.0,
                                )), SizedBox(height: 5.0),
                                Text(news.detail,
                                style: TextStyle(
                                    fontSize: 11.0, color: Colors.grey)),
                            SizedBox(height: 5.0),
                            Row(
                              children: <Widget>[
                                 Text('วันที่ : 13/09/2019',
                                style: TextStyle(
                                  fontFamily: 'AbrilFatFace',
                                  fontSize: 12.0,color: Color(0xFF199693)
                                )),
 
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