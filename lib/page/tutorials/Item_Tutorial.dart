import 'package:flutter/material.dart';

class ItemTutorial extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color bg;
  final String image;

  const ItemTutorial({Key key, this.title, this.subtitle, this.bg, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
      children: <Widget>[
       Center(
         child: Image.asset(
           image,
           width: size.width,
           height: size.height,
           fit: BoxFit.fitHeight,
         ),
       ),

       Padding(
         padding: const EdgeInsets.only(top: 50.0,right: 8,left: 8),
         child: Container(
           width: 400,
           height: 350,
           decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
             color: Colors.black.withOpacity(0.5),
             border: Border.all(width: 2,color: Colors.white)
           ),
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
       ),
      ],
      ),
    );
  }
}
