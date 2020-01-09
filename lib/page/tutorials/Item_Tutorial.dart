import 'package:flutter/material.dart';

class ItemTutorial extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color bg;
  final String image;

  const ItemTutorial({Key key, this.title, this.subtitle, this.bg, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Container(
        color: bg,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
            SizedBox(height: 50,),
              Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'kanit',fontSize: 35,color: Colors.white),)
              ,SizedBox(height: 10,),
              Text(subtitle,style: TextStyle(fontFamily: 'kanit',fontSize: 20,color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }
}
