import 'package:flutter/material.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/page/search/Widget_item_Major.dart';
import 'package:student_guidance/service/SearchService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ItemMajor extends StatefulWidget {
  final String majorName;

  const ItemMajor({Key key, this.majorName}) : super(key: key);
  @override
  _ItemMajorState createState() => _ItemMajorState();
}

class _ItemMajorState extends State<ItemMajor> {
   final TextEditingController _controller = new TextEditingController();
   List<University> listUniversity = new  List<University>();
     @override
  void initState() {
    super.initState();
     SearchService().getListUniversitybyMajor(widget.majorName).then((listUniversityFromService){
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
         title: Text(widget.majorName,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 20,
            )),
        backgroundColor: UIdata.themeColor,
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
                              color: UIdata.themeColor,
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
                'พบทั้งหมด '+listUniversity.length.toString()+' มหาวิทยาลัยที่มีสาขานี้',
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
                      builder: (context) => WidgetItemMajor(
                         university:listUniversity[index],majorName:widget.majorName)));

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