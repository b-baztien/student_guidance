import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:student_guidance/utils/UIdata.dart';

class Home extends StatefulWidget {
  static String tag = "home-page";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  snap: false,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      title: Row(children: <Widget>[
                        FlutterLogo(
                          colors: Colors.yellow,
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text("Student Guidance",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ))
                      ]),
                      background: Image.network(
                        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                        fit: BoxFit.cover,
                      )),
                ),
              ];
            },
            body: Container(
                child: StaggeredGridView.countBuilder(
              padding: EdgeInsets.all(5),
              crossAxisCount: 4,
              itemCount: UIdata.routesName.length,
              itemBuilder: (BuildContext context, int index) => Container(
                    color: Colors.blue,
                    child: RaisedButton(
                      child: Text(
                        UIdata.routesName[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, UIdata.routesName[index]);
                      },
                    ),
                  ),
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(index % 3 == 0 ? 4 : 2 , 1.5),
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
            ))));
  }
}
