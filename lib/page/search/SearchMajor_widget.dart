import 'package:flutter/material.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/service/MajorService.dart';

class SearchMajor extends StatefulWidget {
  @override
  _SearchMajorState createState() => _SearchMajorState();
}

class _SearchMajorState extends State<SearchMajor> {
    final TextEditingController _controller = new TextEditingController();
    List<Major> items = List<Major>();
 List<Major> major;
  @override
  void initState(){
     super.initState();
   MajorService().getAllMajor().then((majorFromService){
    setState(() {
      major = majorFromService;
      items = major;
    });
  }); 
  }
  
  @override
  Widget build(BuildContext context) {
     final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
       resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
                    height: screenHeight,
                    color: Colors.transparent,
                    child: ListView.builder(
                      itemCount: items.length,
                     itemBuilder: (_,i) => listFacultys(ff: items[i],),
                    ),
                   
      )
      
    );
  }
}

class listFacultys extends StatelessWidget {
  final Major ff;
  const listFacultys({Key key, this.ff}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print(ff.majornName);
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.all(6),
          padding: EdgeInsets.all(6),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                child: Text(ff.majornName[0]),
                backgroundColor: Colors.deepOrange[300],
                foregroundColor: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.all(8),
              ),
              Text(ff.majornName),
            ],
          ),
        ),
      ),
    );
  }
  
}
