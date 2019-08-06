import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_guidance/page/home/home-drawer.dart';
import 'package:student_guidance/model/News.dart';
import 'dart:math';

import 'package:student_guidance/utils/UIdata.dart';

class Home extends StatefulWidget {
  static String tag = "home-page";

  @override
  _HomeState createState() => _HomeState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  List<String> _locations = ['แม่โจ้', 'เชียงใหม่', 'พะเยา', 'กรุงเทพ'];
  String _selectedLocation = 'เลือก มหาวิทยาลัย';

  Widget appBarTitle = new Text("What do you want to do ?");
  Icon actionIcon = new Icon(Icons.search);
  Icon menuIcon = new Icon(Icons.menu);
  var currentPage = images.length - 1.0;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);
    Size screenSize = MediaQuery.of(context).size;
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    AppBar homeAppbar() {
      return AppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextField(
                    decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.black),
                      hintText: "ค้นหา มหาวิทยาลัย/คณะ/สาขา",
                    ),
                    autofocus: true,
                    onChanged: (String text) => {print(text)},
                  );
                } else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("What do you want to do ?");
                }
              });
            },
          ),
        ],
      );
    }

    Widget cardScrollWidget(BuildContext context) {
      var padding = 20.0;
      var verticalInset = 20.0;
      return AspectRatio(
        aspectRatio: widgetAspectRatio,
        child: LayoutBuilder(builder: (context, contraints) {
          var width = contraints.maxWidth;
          var height = contraints.maxHeight;

          var safeWidth = width - 2 * padding;
          var safeHeight = height - 2 * padding;

          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;

          List<Widget> cardList = new List();

          for (var i = 0; i < images.length; i++) {
            var delta = i - currentPage;
            bool isOnRight = delta > 0;

            var start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -delta * (isOnRight ? 15 : 1),
                    0.0);

            var cardItem = Positioned.directional(
              top: padding + verticalInset * max(-delta, 0.0),
              bottom: padding + verticalInset * max(-delta, 0.0),
              start: start,
              textDirection: TextDirection.rtl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0)
                  ]),
                  child: AspectRatio(
                    aspectRatio: cardAspectRatio,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.asset(images[i], fit: BoxFit.cover),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Text(
                                  title[i],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: UIdata.fontFamily),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, bottom: 12.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 22.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Text("อ่านเพิ่มเติม",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
          );
        }),
      );
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFF1b1e44),
              Color(0xFF2d3447),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            tileMode: TileMode.clamp),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: HomeDrawer(context).drawer(),
        appBar: homeAppbar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width / 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("ข่าวสารของโรงเรียน",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenSize.width / 18.5,
                          letterSpacing: 1.0,
                        )),
                    IconButton(
                      icon: Icon(
                        Icons.fiber_new,
                        size: 20.0,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFff6e6e),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 6.0),
                          child: Text("Date",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text("จำนวนข่าว..",
                        style: TextStyle(color: Colors.blueAccent))
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  cardScrollWidget(context),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: images.length,
                      controller: controller,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width / 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("ข่าวสารเกี่ยวกับมหาวิทยาลัยที่ติดตาม",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenSize.width / 21,
                          letterSpacing: 1.0,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 6.0),
                          child: Text("Date",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      "จำนวนข่าว",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenSize.height / 30,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 18.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        "assets/images/news_3.jpg",
                        width: screenSize.width / 1.2,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenSize.height / 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
