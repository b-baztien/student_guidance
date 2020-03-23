import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_guidance/service/CareerService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class AddRecommendCarrer extends StatefulWidget {
  @override
  _AddRecommendCarrerState createState() => _AddRecommendCarrerState();
}

class _AddRecommendCarrerState extends State<AddRecommendCarrer> {
  Map<String,bool> values = new Map<String,bool>();
 var tmpArray = [];
@override
  void initState() {
    super.initState();
   CareerService().getAllCareerName().then((carrerName){
     for(String f in carrerName){
     setState(() {
         values[f] = false;
     });
     }
   });
  }
getCheckbox(){
  values.forEach((key,value){
    if(value == true){
  tmpArray.add(key);
    }
  });
   print(tmpArray);
  tmpArray.clear();
}
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
                        UIdata.txRecommendCarrer,
                        style: UIdata.textTitleStyle24,
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              border:
                                  Border.all(width: 2, color: Colors.white)),
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Container(
                                child: Column(
                                    children: values.keys.map((String key){
                                      return  CheckboxListTile(
                                      value: values[key],
                                       onChanged: (bool val){
                                       setState(() {
                                           values[key] = val ;
                                       });
                                       },
                                       title: Text(key),
                                       );
                                    }).toList()
                                  )),
                          ),
                        ),
                      ),
                      Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                             IconButton(icon: Icon(FontAwesomeIcons.exclamationCircle,color: Colors.white,),
                              onPressed: (){

                              }),
                              FlatButton.icon(
                                 shape: StadiumBorder(
                            side: BorderSide(
                              color:Colors.white,
                              width: 2,
                            ),
                          ),
                                onPressed: (){
                                  getCheckbox();
                                 
                                },
                                 icon: Icon(
                        FontAwesomeIcons.save,
                            color: Colors.white,
                            size: 20,
                          ),
                                 label: Text('บันทึก',style: TextStyle(color: Colors.white),))
                             ],
                           ),
                      )

                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}