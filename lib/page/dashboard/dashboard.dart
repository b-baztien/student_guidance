import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:student_guidance/model/ChartData.dart';
import 'package:student_guidance/service/EntranService.dart';
import 'package:student_guidance/utils/UIdata.dart';

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

class _DashboardState extends State<Dashboard> {
  List<charts.Series<ChartData, String>> seriesBarData;
  List<DropdownMenuItem<String>> _dropdownYear;

  Dash _selectedRound;
  String _selectedYear;
  List<DropdownMenuItem<Dash>> _dropdownMenuItem;
  List<Dash> _round = Dash.getRound();
  List<Color> listColor = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green,
    Colors.purple
  ];

  _generateData(Map<String, Map<int, List<ChartData>>> myData) {
    List<ChartData> listChartData = new List<ChartData>();
    Map<int, List<ChartData>> chartMap = new Map<int, List<ChartData>>();
    chartMap = myData[_selectedYear];

    int valueall = 0;
    for (ChartData ch in chartMap[_selectedRound.id]) {
      valueall = valueall + ch.value.toInt();
    }
    for (int i = 0; i < chartMap[_selectedRound.id].length; i++) {
      chartMap[_selectedRound.id][i].value =
          (chartMap[_selectedRound.id][i].value / valueall * 100).toDouble();
      chartMap[_selectedRound.id][i].colorVal = listColor[i];
      listChartData.add(chartMap[_selectedRound.id][i]);
    }

    seriesBarData = List<charts.Series<ChartData, String>>();
    seriesBarData.add(
      charts.Series(
        domainFn: (ChartData chartData, _) => chartData.name,
        measureFn: (ChartData chartData, _) => chartData.value,
        colorFn: (ChartData chartData, _) =>
            charts.ColorUtil.fromDartColor(chartData.colorVal),
        data: listChartData,
        labelAccessorFn: (ChartData row, _) =>
            "${row.value.toStringAsFixed(2)}%",
      ),
    );
  }

  Map<String, Map<int, List<ChartData>>> mapDashboardItem =
      new Map<String, Map<int, List<ChartData>>>();
  List<ChartData> listDashboardItem = new List<ChartData>();
  @override
  void initState() {
    _dropdownMenuItem = buildDropDownMenuItem(_round);
    _selectedRound = _round[0];
    EntranService().getDashboard(_selectedRound.id).then((result) {
      setState(() {
        _dropdownYear = buildDropDownYearItem(result.keys.toList());
        _selectedYear = result.keys.toList()[0];
        mapDashboardItem = result;
        listDashboardItem = mapDashboardItem[_selectedYear][_selectedRound.id];
      });
    });
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
      _selectedYear = null;
      _dropdownYear = null;
    });
    EntranService().getDashboard(selectRound.id).then((result) {
      setState(() {
        _dropdownYear = buildDropDownYearItem(result.keys.toList());
        _selectedYear = result.keys.toList()[0];
        mapDashboardItem = result;
        listDashboardItem = mapDashboardItem[_selectedYear][_selectedRound.id];
      });
    });
  }

  List<DropdownMenuItem<String>> buildDropDownYearItem(List listYear) {
    List<DropdownMenuItem<String>> items = List();
    for (String year in listYear) {
      items.add(
        DropdownMenuItem(
          value: year,
          child: Text(year),
        ),
      );
    }
    return items;
  }

  onChangeDropdownYearItem(String selectYear) {
    setState(() {
      _selectedYear = selectYear;
      listDashboardItem = mapDashboardItem[_selectedYear][_selectedRound.id];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: UIdata.themeColor,
                ),
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
                      child: Column(
                        children: <Widget>[
                          DropdownButton(
                            value: _selectedRound,
                            items: _dropdownMenuItem,
                            onChanged: onChangeDropdownItem,
                          ),
                          DropdownButton(
                            value: _selectedYear,
                            items: _dropdownYear,
                            onChanged: onChangeDropdownYearItem,
                            hint: Text('เลือกปีการศึกษา'),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                        height: MediaQuery.of(context).size.height / 2.5,
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
                        child: Center(
                          child: FutureBuilder(
                            future:
                                EntranService().getDashboard(_selectedRound.id),
                            builder: (_, snapshot) {
                              if (snapshot.hasError)
                                return new Text('Error: ${snapshot.error}');
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Container(
                                      width: 200.0,
                                      child: FlareActor(
                                        "assets/animates/blessing.flr",
                                        animation: 'Preview2',
                                        alignment: Alignment.center,
                                        fit: BoxFit.contain,
                                      ));
                                default:
                                  _generateData(snapshot.data);
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: charts.PieChart(
                                      seriesBarData,
                                      defaultRenderer: charts.ArcRendererConfig(
                                          arcWidth: 70,
                                          arcRendererDecorators: [
                                            charts.ArcLabelDecorator(
                                              labelPosition: charts
                                                  .ArcLabelPosition.inside,
                                              insideLabelStyleSpec:
                                                  new charts.TextStyleSpec(
                                                      fontSize: 10,
                                                      color:
                                                          charts.Color.fromHex(
                                                              code: "#ffffff")),
                                            ),
                                          ]),
                                    ),
                                  );
                              }
                            },
                          ),
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
                      child: ListView.builder(
                        itemCount: listDashboardItem.length,
                        itemBuilder: (_, i) {
                          return Center(
                            child: Text(
                              listDashboardItem[i].name + " " + listDashboardItem[i].value.toInt().toString() + " ครั้ง",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: listColor[i],
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
