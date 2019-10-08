import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:student_guidance/model/EntranceExamResult.dart';
import 'package:student_guidance/service/EntranService.dart';

class Dashboard extends StatefulWidget {
  static String tag = "dashboard-page";
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<charts.Series<EntranceExamResult, String>> seriesBarData;
  List<EntranceExamResult> entran;

  _generateData() async {
    Map<String, List<EntranceExamResult>> entranceData =
        await EntranService().getEntranceExamResultAnalyte().then((result) {
      return result;
    });
    entran = entranceData['2562'];
    seriesBarData = List<charts.Series<EntranceExamResult, String>>();
    seriesBarData.add(
      charts.Series(
        domainFn: (EntranceExamResult examResult, _) =>
            examResult.entrance_exam_name.toString(),
        measureFn: (EntranceExamResult examResult, _) =>
            int.parse(examResult.year),
        id: 'Sales',
        data: entran,
        labelAccessorFn: (EntranceExamResult row, _) => row.year,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    EntranService()
        .getAllEntranceExamResult()
        .then((entranceExamResultFromService) {
      setState(() {
        entran = entranceExamResultFromService;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _generateData();
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: charts.BarChart(
                  seriesBarData,
                  behaviors: [
                    charts.DatumLegend(
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.purple.shadeDefault,
                          fontFamily: 'kanit',
                          fontSize: 18),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
