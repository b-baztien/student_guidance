import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatefulWidget {
  static String tag = "home-page";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  Material MyListItem(IconData icon,String heading,int color){
    
    return Material(
          color: Colors.white,
          elevation: 14.0,
          shadowColor: Color(0x802196F3),
          borderRadius: BorderRadius.circular(24.0),
          child: Center(
              child: Padding( padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //text
                      Padding(
                        padding:const EdgeInsets.all(8.0),
                      child:Text(heading,style: TextStyle(color:new Color(color),
                      fontSize: 20.0
                      ),
                      ),
                      ),
                    //icon
                    Material(
                      color: new Color(color),
                      borderRadius: BorderRadius.circular(24.0),
                      child:Padding(
                        padding:const EdgeInsets.all(16.0),
                        child: Icon(icon,
                        color: Colors.white,
                        size: 30.0,
                        ), 
                    )
                    )



                  ],
                  )
                ],
              ),
              
              ),
      
              

          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text("Collapsing Toolbar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      background: Image.network(
                        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                        fit: BoxFit.cover,
                      )),
                ),
              ];
            },
            body: StaggeredGridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
              children: <Widget>[
                Container(
                  child: FlatButton(
                 color: Colors.white,
                  
                  child: MyListItem(Icons.bookmark,"Bookmark",0xff26cb3c),
                  onPressed:(){
                   Navigator.pushNamed(context, Home.tag);
                }),),
                MyListItem(Icons.library_add,"add",0xff232223),
                 MyListItem(Icons.library_music,"music",0xff232223),
              ],
              staggeredTiles: [
                StaggeredTile.extent(2, 130),
                StaggeredTile.extent(1, 150),
                StaggeredTile.extent(4, 250),
              ],
            )
            
            ));
  }
}
