import 'package:flutter/material.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/page/search/Widget_Item_MajorInFaculty.dart';
import 'package:student_guidance/service/SearchService.dart';

class ItemFaculty extends StatefulWidget {
  final String facultyName;

  const ItemFaculty({Key key, this.facultyName}) : super(key: key);
  @override
  _ItemFacultyState createState() => _ItemFacultyState();
}

class _ItemFacultyState extends State<ItemFaculty> {
  final TextEditingController _controller = new TextEditingController();
  List<University> listUniversity = new  List<University>();
   @override
  void initState() {
    super.initState();
    SearchService().getListUniversity(widget.facultyName).then((listUniversityFromService){
      setState(() {
        listUniversity = listUniversityFromService;
        print(listUniversityFromService.length);
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text(widget.facultyName,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 20,
            )),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: Column(
     children: <Widget>[
       Stack(
         children: <Widget>[
           Column(
             children: <Widget>[
               SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12,right: 12),
                    child: Material(
                      elevation: 5,
                       borderRadius: BorderRadius.circular(10.0),
                         child: TextField(
                        onChanged: (value) {
                         
                        },
                        controller: _controller,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.redAccent,
                              size: 25.0,
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 10.0, top: 12.0),
                            hintText: 'ค้นหาชื่อมหาวิทยาลัย',
                            hintStyle: TextStyle(color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                               setState(() {
                                 _controller.clear();
                               });
                              },
                            )),
                      ),
                    ),
                  ),
                 
         
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
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Text(
                'พบทั้งหมด '+listUniversity.length.toString()+' มหาวิทยาลัย',
                style: TextStyle(color: Colors.grey, fontFamily: 'kanit'),
              ),
            ),
          ),
           _buildExpended()
     ],
      )
    );
  }
  Widget  _buildExpended(){
  return Expanded(
child: ListView.builder(
   
      itemCount: listUniversity.length,
      itemBuilder: (context,index){
        return InkWell(
          onTap: (){
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MajorInFaculty(
                         university:listUniversity[index],faculty:widget.facultyName)));

          },
          child: Container(
          
            child: ListTile(
               contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
               leading: Container(
                        padding: EdgeInsets.only(right: 5,left: 10),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(
                                    width: 2, color: Colors.red))),
                        child:Icon(Icons.school,
                        color: Colors.red, size: 30),
                        ),
                title: Text(
                      listUniversity[index].universityname,
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.red, size: 30),
                    
            ),
          ),
        );
      },
),
  );
}
}
