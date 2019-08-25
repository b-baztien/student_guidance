import 'package:flutter/material.dart';

class ViewEducationDetailScreen extends StatefulWidget {
  @override
  _ViewEducationDetailScreenState createState() => _ViewEducationDetailScreenState();
}

class _ViewEducationDetailScreenState extends State<ViewEducationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(   
                //Colors Theme Education 
                colors:[Colors.green.shade200, Colors.greenAccent.shade400],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
            )
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
            )
        ],
      ),
    );
  }
}