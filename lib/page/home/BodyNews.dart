import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/model/News.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/page/Views/view-education-detail.dart';
import 'package:student_guidance/service/NewsService.dart';
import 'package:student_guidance/service/UniversityService.dart';
import 'package:student_guidance/widgets/customCard.dart';

class BodyNews extends StatelessWidget {

   NewsService newsService = new NewsService();
  

  @override
  Widget build(BuildContext context) {
 Widget  header(){
    return new Container(
        height: 140.0,       
         width: MediaQuery.of(context).size.width,        
        color: Colors.indigo,        
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 60.0),        
               Text('Student Guidance',     
                        style: TextStyle(
            color: Colors.orange[200],
            fontFamily: 'Kanit',          
                    fontSize: 25.0,          
                        fontWeight: FontWeight.bold              ),),          ],        )
    );  
    }

    return Scaffold(
       backgroundColor: Colors.white,
        body: new Column(
        children: <Widget>[
              header(),
       Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo[600],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 6.0),
                          child: Text("ข่าวสาร",
                              style: TextStyle(color: Colors.amber[600],fontFamily: 'Kanit', fontSize: 20.0)),
                              
                        ),
                      ),
                      
                    ),
                  
                   Text('เพิ่มเติม', style: TextStyle(color: Colors.pinkAccent, fontSize: 12.0,fontFamily: 'Kanit'))
                  ],
                ),
              ),
             
          Padding(
              padding: const EdgeInsets.all(15.0),  
              child: Container(
                height: 275.0,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                future: newsService.getNews(),
            builder: (_,snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView.builder(
                      itemCount: snapshot.data.length,
                      
                      itemBuilder: (_, index){
                       News newsFirebase = new  News();
                          newsFirebase.topic = snapshot.data[index].data["topic"];
                          newsFirebase.detail = snapshot.data[index].data["detail"];
                         return new CustomCard(
                            news:newsFirebase,
                          );
                      },
                      scrollDirection: Axis.horizontal,
                      
                    
                    );
                }
              },
            ),
              )
            
          ),
         Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo[600],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 6.0),
                          child: Text("สาขาที่เหมาะกับอาชีพในฝันของคุณ",
                              style: TextStyle(color: Colors.yellow,fontFamily: 'Kanit', fontSize: 15.0)),
                              
                        ),
                      ),
                      
                    ),
                   Text('เพิ่มเติม', style: TextStyle(color: Colors.pinkAccent, fontSize: 12.0,fontFamily: 'Kanit'))
                  ],
                ),
              ),
          SizedBox(height: 10.0),
               Container(
          height: 100.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            
            children: <Widget>[
             
            ],
          ),
        )

        ],
      ),
      
    );
  }
}


