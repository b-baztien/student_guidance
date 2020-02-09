import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/model/Teacher.dart';

class ItemTeacher extends StatefulWidget {
  final String position;
  final List<Teacher> listTeacher;

  const ItemTeacher({Key key, this.position, this.listTeacher}) : super(key: key);

  @override
  _ItemTeacherState createState() => _ItemTeacherState();
}

class _ItemTeacherState extends State<ItemTeacher> with TickerProviderStateMixin  {
 AnimationController _animationController;
    bool toggle;
   @override
  void initState() {
      super.initState();
      toggle = true;
   _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
           GestureDetector(
      onTap: () {
       setState(() {
          toggle = !toggle;
       });
        print(toggle.toString());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
             widget.position,
              style: TextStyle(fontSize: 20,color: Colors.white),
            ),
            toggle == true ? Icon(Icons.keyboard_arrow_down,size: 40,color: Colors.white,) : Icon(Icons.keyboard_arrow_up,size: 40,color:Colors.white)
          ],
        ),
      ),
    ),
      AnimatedSizeAndFade(
            vsync: this,
            child: toggle
                ? SizedBox(
                    key: ValueKey("first"),
                    height: 1,
                  )
                : Container(
                  height: 150,
                    child: ListView.builder(
                        itemCount: widget.listTeacher.length,
                        itemBuilder: (_, index) {
                          return Text(widget.listTeacher[index].firstname);
                        }),
                  ),
            fadeDuration: const Duration(milliseconds: 300),
            sizeDuration: const Duration(milliseconds: 600),
          ),
        ],
      ),
      
    );
  }
 
}