import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_guidance/model/Career.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/service/MajorService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ItemCarrerNew extends StatefulWidget {
  final DocumentSnapshot career;

  const ItemCarrerNew({Key key, this.career}) : super(key: key);
  @override
  _ItemCarrerNewState createState() => _ItemCarrerNewState();
}

class _ItemCarrerNewState extends State<ItemCarrerNew> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final Career _career = Career.fromJson(widget.career.data);
    return SafeArea(
      child: Material(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/career-bg.png'),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: ShaderMask(
                shaderCallback: (bound) => RadialGradient(
                        radius: 4.0,
                        colors: [Colors.yellow, Colors.white],
                        center: Alignment.topLeft,
                        tileMode: TileMode.clamp)
                    .createShader(bound),
                child: Shimmer.fromColors(
                    child: Text(
                      UIdata.txItemCareerTitle,
                      style: UIdata.textTitleStyle,
                    ),
                    baseColor: Colors.greenAccent,
                    highlightColor: Colors.red,
                    period: const Duration(milliseconds: 3000))),
            leading: ShaderMask(
                shaderCallback: (bound) => RadialGradient(
                        radius: 5.0,
                        colors: [Colors.greenAccent, Colors.blueAccent],
                        center: Alignment.topLeft,
                        tileMode: TileMode.clamp)
                    .createShader(bound),
                child: Shimmer.fromColors(
                  child: IconButton(
                    icon: UIdata.backIcon,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  baseColor: Colors.greenAccent,
                  highlightColor: Colors.blueAccent,
                  period: const Duration(milliseconds: 3000),
                )),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              FutureBuilder(
                                future:
                                    GetImageService().getImage(_career.image),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      height: 140.0,
                                      width: 140.0,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(snapshot.data),
                                              fit: BoxFit.fitHeight)),
                                    );
                                  } else {
                                    return Container(
                                      height: 140.0,
                                      width: 140.0,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/career.png'),
                                              fit: BoxFit.fitHeight)),
                                    );
                                  }
                                },
                              ),
                              Text(_career.careerName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 7,
                          decoration: BoxDecoration(color: Color(0xffEBEBEB)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SelectableText(
                            _career.description,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'สาขาเกี่ยวข้อง',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        StreamBuilder<List<String>>(
                          stream: MajorService()
                              .getListMajorNameByCareerName(_career.careerName),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<String>> snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: snapshot.data
                                    .map((majorName) => Text(
                                          majorName,
                                          style: UIdata.textTitleStyle,
                                        ))
                                    .toList(),
                              );
                            } else {
                              return Text(
                                'ไม่พบสาขา',
                                style: UIdata.textTitleStyle,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
