import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:student_guidance/model/EntranceExamResult.dart';
import 'package:student_guidance/service/EntranService.dart';
import 'dart:math' as math;

class Dashboard extends StatefulWidget {
  static String tag = "dashboard-page";
  @override
  _DashboardState createState() => _DashboardState();
}

class Dash {
  int id;
  String name = '';
  Dash(this.id, this.name);
  static List<Dash> getRound() {
    return <Dash>[
      Dash(1, '5 อันดับมหาลัยสอบติดยอดนิยม'),
      Dash(2, '5 อันดับคณะสอบติดยอดนิยม'),
      Dash(3, '5 อันดับสาขาสอบติดยอดนิยม'),
      Dash(4, '10 อันดับมหาวิทยาลัยยอดนิยม'),
      Dash(5, '5 อันดับ'),
    ];
  }
}

class Test {
  String year;
  double value;
  Color colorVal = Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
      .withOpacity(1.0);
}

class _DashboardState extends State<Dashboard> {
  List<charts.Series<Test, String>> seriesBarData;
  List<Test> entran;
    Dash _selectedRound;
  Map<String, List<EntranceExamResult>> entranceData;
  List<DropdownMenuItem<Dash>> _dropdownMenuItem;
  List<Dash> _round = Dash.getRound();
  _generateData(myData) {
    List<Test> listTest = new List<Test>();
    int valueall = 0;
    for (String year in myData.keys.toList()) {
      valueall = valueall + myData[year].length;
    }
    print(valueall);
    for (String year in myData.keys.toList()) {
      Test t = new Test();
      t.year = year;
      t.value = ((myData[year].length / valueall) * 100);
      listTest.add(t);
    }
    entran = listTest;
    seriesBarData = List<charts.Series<Test, String>>();
    seriesBarData.add(
      charts.Series(
        domainFn: (Test test, _) => test.year,
        measureFn: (Test test, _) => test.value,
        colorFn: (Test test, _) =>
            charts.ColorUtil.fromDartColor(test.colorVal),
        id: 'Sales',
        data: entran,
        labelAccessorFn: (Test row, _) => "${row.value}%",
      ),
    );
  }

  @override
  void initState() {
    _dropdownMenuItem = buildDropDownMenuItem(_round);
      _selectedRound = _round[0];
    super.initState();
  }

  List<DropdownMenuItem<Dash>> buildDropDownMenuItem(List rounded) {
    List<DropdownMenuItem<Dash>> items = List();
    for (Dash round in rounded) {
      items.add(
        DropdownMenuItem(
          value: round,
          child: Text(round.name),
        ),
      );
    }
    return items;
  }

  
  onChangeDropdownItem(Dash selectRound) {
    setState(() {
      _selectedRound = selectRound;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 180,
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.green, Colors.blue[300]])),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      'แผนภูมิ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          Container(
            child: Column(
              children: <Widget>[
                 Container(
                   margin: EdgeInsets.only(top: 100, right: 10, left: 10),
                  width: 350,
                  height: 100,
                   decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff444444).withOpacity(.1),
                              blurRadius: 20,
                              spreadRadius: 10),
                        ]),
                        child: Column(children: <Widget>[
                         DropdownButton(
                            value: _selectedRound,
                            items: _dropdownMenuItem,
                            onChanged: onChangeDropdownItem,
                          ),
                        Center(
                          child: Text(
                            "ปี",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          
                        ), 
                    
                        ],),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                    height: 350,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff444444).withOpacity(.1),
                              blurRadius: 20,
                              spreadRadius: 10),
                        ]),
                    child: Stack(
                      children: <Widget>[
                        FutureBuilder(
                          future: EntranService().getEntranceExamResultAnalyte(),
                          builder: (_, snapshot) {
                            if (snapshot.hasError)
                              return new Text('Error: ${snapshot.error}');
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return new Text('Loading...');
                              default:
                                _generateData(snapshot.data);
                                return 
                                  charts.PieChart(
                                    seriesBarData,
                                    behaviors: [
                                      
                                    ],
                                    defaultRenderer: charts.ArcRendererConfig(
                                        arcWidth: 75,
                                        
                                        
                                        arcRendererDecorators: [
                                          charts.ArcLabelDecorator(
                                            
                                              labelPosition:
                                                  charts.ArcLabelPosition.inside,
                                                  
                                                    insideLabelStyleSpec: new charts.TextStyleSpec(fontSize: 16, color: 
                                                    charts.Color.fromHex(code: "#FFFFFF")),
                                                    
                                                  
                                                  ),
                                                  
                                        ]),
                                  );
                              
                            }
                          },
                        ),
                        // Center(
                        //   child: Text(
                        //     "Test text%",
                        //     style: TextStyle(
                        //         fontSize: 15.0,
                        //         color: Colors.blue,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
         
                      ],
                    ),
                  ),
                ),
                Container(
                   margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                  width: 350,
                  height: 150,
                   decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff444444).withOpacity(.1),
                              blurRadius: 20,
                              spreadRadius: 10),
                        ]),
                        child: Column(children: <Widget>[
                           Center(
                          child: Text(
                            "Test 1",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ), Center(
                          child: Text(
                            "Test 2",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ), Center(
                          child: Text(
                            "Test 3",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ), Center(
                          child: Text(
                            "Test 4",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ), Center(
                          child: Text(
                            "Test 5",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ],),
                )
              
              ],
            ),
          ),
        ],
      ),
    );
  }
}
