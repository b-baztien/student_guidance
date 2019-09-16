import 'package:flutter/material.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/UniversityService.dart';

import 'ItemsUniversity.dart';
class SearchUniversityWidget extends StatefulWidget {
  @override
  _SearchUniversityWidgetState createState() => _SearchUniversityWidgetState();
}
 List<String> university = UniversityService().getListUniversity();

class _SearchUniversityWidgetState extends State<SearchUniversityWidget> {
 var items = List<String>();
 final TextEditingController _controller = new TextEditingController();
  @override
  void initState(){
    items.addAll(university);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
  
 return Scaffold(
   resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: 
      Column(
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
                      SearchResult(value);
                      
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search,color: Colors.pinkAccent,size: 25.0,),
                      contentPadding: EdgeInsets.only(left: 10.0,top: 12.0),
                      hintText: 'ค้นหามหาวิทยาลัย',hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: (){
                          this.setState((){
                             _controller.clear();
                            items.addAll(university);
                          });
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
              
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(10),
               
                height: 40,
                 width: MediaQuery.of(context).size.width,        
                decoration: BoxDecoration(
                  color: Colors.grey[300]
                ),
                
                  child: Text('พบทั้งหมด '+ items.length.toString()+' มหาวิทยาลัย',style: TextStyle(color: Colors.indigo,fontFamily: 'kanit'),),
                
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context,index){
                  return ItemsUniversity(universitys : items[index]);
                },
              ),
            )
          
           
      ],
      ),

    );
  }

void SearchResult(String query){
  List<String> _SearchList = List<String>();
  _SearchList.addAll(university);
  if(query.isNotEmpty){
    List<String> _SearchData = List<String>();
    _SearchList.forEach((item){
      if(item.contains(query)){
        _SearchData.add(item);
      }
    });
    setState(() {
     items.clear();
     items.addAll(_SearchData);
    });
    return;

  }else{
    setState(() {
      items.clear();
     items.addAll(university);
    });
  }
}

}

