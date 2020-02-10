import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/model/Teacher.dart';
import 'package:student_guidance/service/GetImageService.dart';

class ItemTeacher extends StatefulWidget {
  final String position;
  final List<Teacher> listTeacher;

  const ItemTeacher({Key key, this.position, this.listTeacher})
      : super(key: key);

  @override
  _ItemTeacherState createState() => _ItemTeacherState();
}

class _ItemTeacherState extends State<ItemTeacher>
    with TickerProviderStateMixin {
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
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  toggle == true
                      ? Icon(
                          Icons.keyboard_arrow_down,
                          size: 40,
                          color: Colors.white,
                        )
                      : Icon(Icons.keyboard_arrow_up,
                          size: 40, color: Colors.white)
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
                    height: widget.listTeacher.length * 150.0,
                    child: ListView.builder(
                        itemCount: widget.listTeacher.length,
                        itemBuilder: (context, index) {
                          return cardItem(context, widget.listTeacher[index]);
                        }),
                  ),
            fadeDuration: const Duration(milliseconds: 200),
            sizeDuration: const Duration(milliseconds: 400),
          ),
        ],
      ),
    );
  }

  Widget cardItem(BuildContext context, Teacher teacher) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      width: double.infinity,
      height: 130,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 3, color: Colors.orange)),
            child: FutureBuilder(
                future: GetImageService().getImage(teacher.image),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data),
                      radius: 40,
                    );
                  } else {
                    return CircleAvatar(
                      radius: 40,
                    );
                  }
                }),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(teacher.firstname +' '+ teacher.lastname,style: TextStyle(fontSize: 20,fontFamily: 'kanit'),),
                Text(teacher.position,style: TextStyle(fontSize: 14,fontFamily: 'kanit',color: Colors.orange),),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: <Widget>[
                           Icon(Icons.phone,color: Colors.white,),
                           SizedBox(width: 10,),
                           Text('โทร',style: TextStyle(color: Colors.white,fontFamily: 'kanit'),)
                         ],
                      ),
                    ),
                     Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)
                      ),
                         child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: <Widget>[
                           Icon(Icons.email,color: Colors.white,),
                           SizedBox(width: 10,),
                           Text('อีเมล์',style: TextStyle(color: Colors.white,fontFamily: 'kanit'),)
                         ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
       
        ],
      ),
    );
  }
}
