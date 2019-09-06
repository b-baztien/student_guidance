import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_guidance/styleguide.dart';

class ViewEducationDetailScreen extends StatefulWidget {
  final String name;
  final double _expendedBottomSheetBottomPosition = 0;
  final double _collapsedBottomSheetBottomPosition = -125;
  final double _completeCollapsedBottomSheetBottomPosition = -330;
  const ViewEducationDetailScreen({Key key, this.name}) : super(key: key);

  @override
  _ViewEducationDetailScreenState createState() => _ViewEducationDetailScreenState();
}

class _ViewEducationDetailScreenState extends State<ViewEducationDetailScreen>with AfterLayoutMixin<ViewEducationDetailScreen> {
  double _bottomSheetBottomPosition = -330;
  bool isCollapsed = false ;
  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: "background-${widget.name}",
           child: DecoratedBox(
              decoration: BoxDecoration(
              gradient: LinearGradient(   
                //Colors Theme Education 
                colors:[Colors.green.shade200, Colors.greenAccent.shade400],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
            )
            ),
           ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0,left: 16),
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.close),
                    color: Colors.white.withOpacity(0.9),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
            
            AnimatedPositioned(
              duration: const Duration(microseconds: 500),
              curve: Curves.decelerate,
              bottom: _bottomSheetBottomPosition,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                    onTap: _onTap,
                   child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      height: 80,
                      child: Text(
                        "อะไรสักอย่าง!",
                        style: AppTheme.subHeading.copyWith(color: Colors.black),
                      ),
                    ),
                      ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _detailWidget(),
                    ),
                   
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
  

  Widget _detailWidget() {
    return Container(
      height: 125,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              roundedContainer(Colors.redAccent),
            ],
          ),
          SizedBox(width: 16),
          Column(
            children: <Widget>[
              roundedContainer(Colors.orangeAccent),
            ],
          ),
          SizedBox(width: 16),
          Column(
            children: <Widget>[
              roundedContainer(Colors.grey),
            ],
          ),
          SizedBox(width: 16),
          Column(
            children: <Widget>[
              roundedContainer(Colors.lightGreenAccent),
            
            ],
          ),
           SizedBox(width: 16),
          Column(
            children: <Widget>[
              roundedContainer(Colors.pinkAccent),
            ],
          ),
        ],
      ),
    );
  }
  Widget roundedContainer(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
 

 _onTap() {
    setState(() {
      _bottomSheetBottomPosition = isCollapsed
          ? widget._expendedBottomSheetBottomPosition
          : widget._collapsedBottomSheetBottomPosition;
      isCollapsed = !isCollapsed;
    });
  }
  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(microseconds: 500),(){
    setState(() {
     isCollapsed = true;
     _bottomSheetBottomPosition = widget._collapsedBottomSheetBottomPosition; 
    });
    }
    );
   
    
    // TODO: implement afterFirstLayouts
  }
}