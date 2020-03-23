import 'package:flutter/material.dart';
import 'package:student_guidance/model/FilterSeachItems.dart';
import 'package:student_guidance/service/SearchService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class AddRecommend extends StatefulWidget {
  @override
  _AddRecommendState createState() => _AddRecommendState();
}

class _AddRecommendState extends State<AddRecommend> {
 Map<String,bool> values = new Map<String,bool>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Color(0xff003471)])),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 8, left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Text(
                        UIdata.txRecommend,
                        style: UIdata.textTitleStyle24,
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 600,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              border:
                                  Border.all(width: 2, color: Colors.white)),
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Container(
                                child: StreamBuilder(
                              stream: SearchService().getAllSearchItem(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                     
                                  List<FilterSeachItems> list = snapshot.data;
                                  List<FilterSeachItems> listItem =
                                      new List<FilterSeachItems>();
                                  for (FilterSeachItems f in list) {
                                    if (f.type == 'Major') {
                                      values[f.name] = false;
                                      listItem.add(f);
                                    }
                                  }
                                  return Column(
                                    children: values.keys.map((String key){
                                      return  CheckboxListTile(
                                      value: values[key],
                                       onChanged: (bool val){
                                       setState(() {
                                         print(val);
                                           values[key] = val ;
                                       });
                                       },
                                       title: Text(key),
                                       );
                                    }).toList()
                                  );
                                } else {
                                  return SizedBox(height: 1);
                                }
                              },
                            )),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
