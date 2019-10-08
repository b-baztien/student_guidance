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

class Test {
  String year;
  int value;
  Color colorVal = Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
}

class _DashboardState extends State<Dashboard> {
  List<charts.Series<Test, String>> seriesBarData;
  List<Test> entran;
  Map<String, List<EntranceExamResult>> entranceData;

  _generateData(myData) {
    List<Test> listTest = new List<Test>();
    for (String year in myData.keys.toList()) {
      Test t = new Test();
      t.year = year;
      t.value = myData[year].length;
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
        labelAccessorFn: (Test row, _) => "${row.value}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
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
                      return Expanded(
                        child: charts.BarChart(
                          seriesBarData,
                          behaviors: [
                            charts.DatumLegend(
                              entryTextStyle: charts.TextStyleSpec(
                                  color: charts
                                      .MaterialPalette.purple.shadeDefault,
                                  fontFamily: 'kanit',
                                  fontSize: 18),
                            )
                          ],
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
