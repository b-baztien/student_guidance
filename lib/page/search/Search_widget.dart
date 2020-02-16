import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/model/FilterItems.dart';
import 'package:student_guidance/model/FilterSeachItems.dart';
import 'package:student_guidance/page/Search/Widget_Item_Career.dart';
import 'package:student_guidance/page/search/ItemFaculty.dart';
import 'package:student_guidance/page/search/ItemMajor.dart';
import 'package:student_guidance/page/search/ItemsUniversity.dart';
import 'package:student_guidance/service/SearchService.dart';
import 'package:student_guidance/service/UniversityService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = new TextEditingController();
  Fliteritems ff = new Fliteritems();
  List<Fliteritems> _listFilter = filterItemsList;
  List<FilterSeachItems> items = List<FilterSeachItems>();
  List<FilterSeachItems> itemsAfterChooseFilter = List<FilterSeachItems>();
  List<FilterSeachItems> listSearch;

  @override
  void initState() {
    super.initState();
    SearchService().getItemSearch().then((itemFromService) {
      setState(() {
         for(Fliteritems f in _listFilter){
            f.b = false;
          }
        listSearch = itemFromService;
        items = listSearch;
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สนใจอะไรอยู่ลองค้นหาดูสิ',
            style: TextStyle(
              color: UIdata.fontColor,
              fontFamily: UIdata.fontFamily,
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
                    padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                          
                            items = itemsAfterChooseFilter.where((w) => (w.name.toLowerCase().contains(value.toLowerCase()))).toList();
                          });
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
                            hintText: 'ค้นหา ?',
                            hintStyle: TextStyle(color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _controller.clear();
                                  items = itemsAfterChooseFilter;
                                });
                              },
                            )),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 3),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 1,
                  runSpacing:1,
                  children: <Widget>[
                    for (var i = 0; i < _listFilter.length; i++)
                      filterChipWidget(_listFilter[i])
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.all(10),
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Text(
                'พบทั้งหมด ' + items.length.toString() + ' รายการ',
                style: TextStyle(color: UIdata.themeColor, fontFamily: UIdata.fontFamily),
              ),
            ),
          ),
          _buildExpended()
        ],
      ),
    );
  }

  Widget filterChipWidget(Fliteritems chipname) {
    return FilterChip(
      label: Text(chipname.name),
      labelStyle: TextStyle(
          color: UIdata.themeColor,
          fontFamily: UIdata.fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.bold),
      selected: chipname.b,
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          if (isSelected){
       
        if(chipname.name == "มหาวิทยาลัย"){
          for(Fliteritems f in _listFilter){
            f.b = false;
          }
           chipname.b = true;
           List<FilterSeachItems> itemsNew = List<FilterSeachItems>();
          for(FilterSeachItems f in listSearch){
            if(f.type=="University"){
              itemsNew.add(f);
            }
          }
          itemsAfterChooseFilter = itemsNew;
          items = itemsNew;
        }
         if(chipname.name == "คณะ"){
            for(Fliteritems f in _listFilter){
            f.b = false;
          }
            chipname.b = true;
           List<FilterSeachItems> itemsNew = List<FilterSeachItems>();
          for(FilterSeachItems f in listSearch){
            if(f.type=="Faculty"){
              itemsNew.add(f);
            }
          }
           itemsAfterChooseFilter = itemsNew;
          items = itemsNew;
        }
         if(chipname.name == "สาขา"){
            for(Fliteritems f in _listFilter){
            f.b = false;
          }
            chipname.b = true;
           List<FilterSeachItems> itemsNew = List<FilterSeachItems>();
          for(FilterSeachItems f in listSearch){
            if(f.type=="Major"){
              itemsNew.add(f);
            }
          }
           itemsAfterChooseFilter = itemsNew;
          items = itemsNew;
        }
           if(chipname.name == "อาชีพ"){
              for(Fliteritems f in _listFilter){
            f.b = false;
          }
              chipname.b = true;
           List<FilterSeachItems> itemsNew = List<FilterSeachItems>();
          for(FilterSeachItems f in listSearch){
            if(f.type=="Career"){
              itemsNew.add(f);
            }
          }
           itemsAfterChooseFilter = itemsNew;
          items = itemsNew;
        }
          }
          else{
chipname.b = false;
if(chipname.name == "มหาวิทยาลัย"){
          items = listSearch;
         itemsAfterChooseFilter = listSearch;
        }
        if(chipname.name == "คณะ"){
          items = listSearch;
         itemsAfterChooseFilter = listSearch;
        }
        if(chipname.name == "สาขา"){
          items = listSearch;
           itemsAfterChooseFilter = listSearch;
        
        }
        if(chipname.name == "อาชีพ"){
          items = listSearch;
           itemsAfterChooseFilter = listSearch;
        }
          }
            
        });
      },
    );
  }

  Widget _buildExpended() {
    return Expanded(
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
        color: Colors.black,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        
        return InkWell(
          onTap: () {
            print(items[index].documentSnapshot);
            UniversityService().updateView(items[index].documentSnapshot);
            if (items[index].type == 'University') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemUniversity(
                          universitys: items[index].documentSnapshot)));
            }
            if(items[index].type == 'Faculty'){
               Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemFaculty(
                          facultyName: items[index].name)));
            }
              if(items[index].type == 'Major'){
               Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemMajor(
                          majorName: items[index].name)));
            }
              if(items[index].type == 'Career'){
               Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemCareer(
                          career: items[index].name)));
            }

          },
         
            child: Container(
                child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    leading: Container(
                        padding: EdgeInsets.only(right: 5.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(
                                    width: 1.0, color: Colors.black))),
                        child: test(items[index].type),
                        ),
                    
                    title: Text(
                      items[index].name,
                      style: TextStyle(
                          color: UIdata.themeColor,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.black, size: 30.0)
                        )
                        ),
        
        );
      },
    ));
  }

  test(String type) {
    if (type == 'University') {
      return Text(
        'มหาวิทยาลัย',
        style: TextStyle(color: UIdata.themeColor),
      );
    }
    if (type == 'Faculty') {
      return Text(
        'คณะ',
        style: TextStyle(color: UIdata.themeColor),
      );
    }
    if (type == 'Major') {
      return Text(
        'สาขา',
        style: TextStyle(color: UIdata.themeColor),
      );
    }
    if (type == 'Career') {
      return Text(
        'อาชีพ',
        style: TextStyle(color: UIdata.themeColor),
      );
    }
  }
}
