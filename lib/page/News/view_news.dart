import 'package:flutter/material.dart';
import 'package:student_guidance/model/News.dart';

class ViewNewsPage extends StatelessWidget {
  ViewNewsPage({@required this.news});
  final News news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: ListView(
         children: <Widget>[
           Stack(children: <Widget>[
          
             Container(
               height: 350.0,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
                 image: DecorationImage(
                                        image:new NetworkImage('https://firebasestorage.googleapis.com/v0/b/studentguidance-1565684067738.appspot.com/o/373659.jpg?alt=media&token=fa1b7cdd-57f0-4eb8-ad1c-1fdb25809255'),
                                        fit: BoxFit.cover)
               ),
             ),
                   Positioned(
            top: 15.0,
            left: 10.0,
            right: 10.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          ),
       
           ],
           ),
           SizedBox(height: 10.0),
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
                                  Text(news.topic,
                                  style: TextStyle(
                                    fontFamily: 'AbrilFatFace',
                                    fontSize: 20.0,
                                  )
                                  ),
                                  Text('วันที่ : 13/09/2019',
                                  style: TextStyle(
                                    fontFamily: 'AbrilFatFace',
                                    fontSize: 11.0,
                                    color: Colors.grey
                                  )
                                  )
                                ],
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.green[300],
                                size: 30.0,
                              )
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            child: Text('บลา ๆ DETAIL NEWS',
                            style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey
                                    )
                            ),
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
