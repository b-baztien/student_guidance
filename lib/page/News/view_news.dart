import 'package:flutter/material.dart';
import 'package:student_guidance/model/News.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ViewNewsPage extends StatelessWidget {
  ViewNewsPage({@required this.news});
  final News news;

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
                                    fontFamily: 'AbrilFatFace',
                                    fontSize: 15.0,
                                    color: Colors.grey
                                  )
                                  ),
                                  Text(news.topic,
                                  style: TextStyle(
                                    fontFamily: 'AbrilFatFace',
                                    fontSize: 30.0,
                                  )
                                  ),
                                
                                ],
                              ),
                             
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            child: Text('โดย .....',
                            style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.grey
                                    )
                            ),
                          ),
                           SizedBox(height: 10.0),
                          Container(
                            child: Text(news.detail,
                            style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black.withOpacity(0.7)
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
