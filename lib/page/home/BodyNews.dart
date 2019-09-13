import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/model/News.dart';
import 'package:student_guidance/page/Views/view-education-detail.dart';
import 'package:student_guidance/service/NewsService.dart';
import 'package:student_guidance/widgets/customCard.dart';

class BodyNews extends StatelessWidget {

   NewsService newsService;
  Future getNews() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('News').getDocuments();
    return qn.documents;
  }


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
          Stack(
            children: <Widget>[
              header(),
              Column(children: <Widget>[
                 SizedBox(height: 110.0,), 
                 Padding(padding: EdgeInsets.only(left: 12.0, right: 12.0),
                 child: Material(
                   elevation: 5.0,
                   borderRadius: BorderRadius.circular(10.0),
                   child: TextField(
                   
                    onTap: (){
                      showSearch(context: context,delegate: Datasearch());
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search,color: Colors.pinkAccent,size: 25.0,),
                      contentPadding: EdgeInsets.only(left: 10.0,top: 12.0),
                      hintText: 'มหาวิทยาลัย, คณะ, สาขา',hintStyle: TextStyle(color: Colors.grey)
                      
                    ),
                   ),
                   
                   
                 ),
                 
                 )
              ],)
            ],
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
                  future: getNews(),
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
                          child: Text("มหาลัยแนะนำ",
                              style: TextStyle(color: Colors.yellow,fontFamily: 'Kanit', fontSize: 20.0)),
                              
                        ),
                      ),
                      
                    ),
                   Text('เพิ่มเติม', style: TextStyle(color: Colors.pinkAccent, fontSize: 12.0,fontFamily: 'Kanit'))
                  ],
                ),
              ),



        ],
      ),
      
    );
  }
}

class Datasearch extends SearchDelegate<String>{
  final university = [
    "มหาวิทยาลัยน่าน",
    "มหาวิทยาลัยแพร่",
    "มหาวิทยาลัยแม่ฮ่องสอน",
    "มหาวิทยาลัยสุราษฎร์ธานี",
  "มหาวิทยาลัยสุรินทร์",
  "มหาวิทยาลัยหนองคาย"
  ];
  final recentUniversity =[
  "มหาวิทยาลัยแม่ฮ่องสอน",
  "มหาวิทยาลัยสุราษฎร์ธานี",
  "มหาวิทยาลัยสุรินทร์",
  "มหาวิทยาลัยหนองคาย"
  ];


  @override
  List<Widget> buildActions(BuildContext context) {
    //action appbar
    return [IconButton(icon: Icon(Icons.clear),
    onPressed: (){
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    
   return Center(
        child: Text(
          '"$query"\n ไม่พบข้อมูลที่ค้นหา.\nลองค้นหาด้วยคำอื่น',
          textAlign: TextAlign.center,
        ),
      );
    

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
    ?recentUniversity
    :university.where((p) => p.toLowerCase().contains(query)).toList();
    return ListView.builder(
        itemBuilder: (context,index) => ListTile(
          onTap: (){
            query = suggestionList[index];
          var route = new MaterialPageRoute(
            builder: (BuildContext context) => new ViewEducation(value : query),
          );
          Navigator.of(context).push(route);
           
          
          },
          leading: new Tab(icon: new Image.asset("assets/images/icon1.png")),
          title: Text(suggestionList[index]
           
          ),
        ),
    itemCount: suggestionList.length,
    );

  }

}