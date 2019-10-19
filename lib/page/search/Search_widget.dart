import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/model/FilterItems.dart';
import 'package:student_guidance/model/FilterSeachItems.dart';
import 'package:student_guidance/page/search/ItemsUniversity.dart';
import 'package:student_guidance/service/SearchService.dart';
import 'package:student_guidance/service/UniversityService.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = new TextEditingController();
  Fliteritems ff = new Fliteritems();
  List<Fliteritems> _listFilter = filterItemsList;
  List<FilterSeachItems> items = List<FilterSeachItems>();
  List<FilterSeachItems> listSearch;

  @override
  void initState() {
    super.initState();
    SearchService().getItemSearch().then((itemFromService) {
      setState(() {
        listSearch = itemFromService;
        items = listSearch;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('สนใจอะไรอยู่ลองค้นหาดูสิ',
            style: TextStyle(
              color: Colors.orange[200],
              fontFamily: 'Kanit',
              fontSize: 20,
            )),
        backgroundColor: Colors.indigo,
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
                        onChanged: (value) {},
                        controller: _controller,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.indigo,
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
                                  items = listSearch;
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
                  spacing: 5,
                  runSpacing: 3,
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
                style: TextStyle(color: Colors.indigo, fontFamily: 'kanit'),
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
          color: Colors.indigo,
          fontFamily: 'kanit',
          fontSize: 13,
          fontWeight: FontWeight.bold),
      selected: chipname.b,
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          if (isSelected)
            chipname.b = true;
          else
            chipname.b = false;
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
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.black, size: 30.0))),
        
        );
      },
    ));
  }

  test(String type) {
    if (type == 'University') {
      return Text(
        'มหาวิทยาลัย',
        style: TextStyle(color: Colors.indigo),
      );
    }
    if (type == 'Faculty') {
      return Text(
        'คณะ',
        style: TextStyle(color: Colors.indigo),
      );
    }
    if (type == 'Major') {
      return Text(
        'สาขา',
        style: TextStyle(color: Colors.indigo),
      );
    }
    if (type == 'Carrer') {
      return Text(
        'อาชีพ',
        style: TextStyle(color: Colors.indigo),
      );
    }
  }
}
