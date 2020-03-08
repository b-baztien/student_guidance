import 'package:flutter/material.dart';

class TabbarItem extends StatefulWidget {
  @override
  _TabbarItemState createState() => _TabbarItemState();
}

class _TabbarItemState extends State<TabbarItem> {
 List<Widget> con = [
      Container(
        color: Colors.deepOrange,
      ),
       Container(
        color: Colors.white,
      ),
       Container(
        color: Colors.blue,
      ),
       Container(
        color: Colors.green,
      ),
       Container(
        color: Colors.yellow,
      ),
    ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Color(0xffFF9211),
            labelColor: Color(0xffFF9211),
            unselectedLabelColor: Color(0xff939191),
           isScrollable: true,
            tabs: <Widget>[
              Tab(
               text: 'รอบ 1',
              ),
              Tab(
                  text: 'รอบ 2',
              ),
              Tab(
              text: 'รอบ 3',
              ),
              Tab(
                  text: 'รอบ 4',
              ),
              Tab(
                 text: 'รอบ 5',
              ),
            ],

          ),
        
        ),
        body: 
           TabBarView(children: con)
      
      ),
      
    );
  }
}