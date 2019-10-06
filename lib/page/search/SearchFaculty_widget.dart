import 'package:flutter/material.dart';

class SearchFaculty extends StatefulWidget {
  @override
  _SearchFacultyState createState() => _SearchFacultyState();
}

class _SearchFacultyState extends State<SearchFaculty> {
  final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 10.0,), 
                   Padding(padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Material(
                   elevation: 5.0,
                   borderRadius: BorderRadius.circular(10.0),
                   child: TextField(
                    onChanged: (value){
                
                      
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search,color: Colors.pinkAccent,size: 25.0,),
                      contentPadding: EdgeInsets.only(left: 10.0,top: 12.0),
                      hintText: 'ค้นหาคณะ',hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: (){
                        
                        },
                      )
                      
                    ),
                    
                   ),

                 ),
                   )
                  ],
                )
              ],
            ),
        ],
      ),
      
    );
  }
}