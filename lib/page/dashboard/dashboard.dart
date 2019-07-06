import 'package:flutter/material.dart';
import 'package:student_guidance/page/home/home.dart';
import 'package:student_guidance/utils/UIdata.dart';

class Dashboard extends StatefulWidget {
  static String tag = "dashboard-page";
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('ข้อมูลเชิงสถิติ'),
          leading: IconButton(
            icon: UIdata.actionIcon,
            onPressed: () {
              Navigator.pushNamed(context, UIdata.homeTag);
            },
          ),
        ),
      ),
    );
  }
}
