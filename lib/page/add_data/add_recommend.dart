import 'package:flutter/material.dart';
import 'package:student_guidance/utils/UIdata.dart';

class AddRecommend extends StatefulWidget {
  @override
  _AddRecommendState createState() => _AddRecommendState();
}

class _AddRecommendState extends State<AddRecommend> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/edit-img.png"),
                  fit: BoxFit.fitHeight)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor:Colors.transparent,
                title: Text(
                  UIdata.txRecommend,
                  style: UIdata.textTitleStyle,
                ),
                leading: IconButton(
                  icon: UIdata.backIcon,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 8, left: 8),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.5),
                      border: Border.all(width: 2, color: Colors.white)),
                      padding:  const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                         
                            ],
                          ),
                        ),
                      ),
                ),
              ),
            ),
          ),
    );
  }
}