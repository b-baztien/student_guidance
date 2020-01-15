import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
           title: myAppbar(),
            pinned: true,
            expandedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(

            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
               Padding(
                 padding: EdgeInsets.only(top: 10,right: 10,left: 20,bottom: 10),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     Text('ข่าว',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                     IconButton(
                       icon:  Icon(FontAwesomeIcons.calendarAlt),
                       onPressed: () {
                       print("calendar");
                       },
                     ),
                   ],
                 ),
               )
              ]
            ),
          )
        ],
      ),
      ),


    );
  }
  Widget myAppbar(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(FontAwesomeIcons.alignLeft),
      ),
    );
  }
}
