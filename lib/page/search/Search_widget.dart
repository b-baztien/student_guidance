import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/model/FilterItems.dart';
import 'package:student_guidance/page/search/ItemsUniversity.dart';
import 'package:student_guidance/service/UniversityService.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = new TextEditingController();
  Fliteritems ff = new Fliteritems();
  List<Fliteritems> _listFilter = filterItemsList;
  List<String> listItem = ['test1', 'test2'];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                'พบทั้งหมด รายการ',
                style: TextStyle(color: Colors.indigo, fontFamily: 'kanit'),
              ),
            ),
          ),
          streamBuild()
        ],
      ),
    );
  }

  Widget streamBuild() {
    return StreamBuilder(
      stream: Firestore.instance.collection('University').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Load...');
        return _buildExpended(context, snapshot);
      },
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

  Widget _buildExpended(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return Expanded(
        child: ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: snapshot.data.documents.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
           UniversityService().updateView(snapshot.data.documents[index]);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ItemUniversity(
                        universitys: snapshot.data.documents[index])));
          },
          child: Card(
            child: Container(
              margin: EdgeInsets.all(6),
              padding: EdgeInsets.all(6),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Text(
                        snapshot.data.documents[index]['university_name'][0]),
                    backgroundColor: Color(0xFF20D3D2),
                    foregroundColor: Colors.black87,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                  ),
                  Text(snapshot.data.documents[index]['university_name']),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
