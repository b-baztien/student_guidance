import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_guidance/model/Major.dart';
import 'package:student_guidance/utils/UIdata.dart';

class ItemMajorNew extends StatefulWidget {
  final String universityName;
  final String facultyName;
  final DocumentSnapshot major;

  const ItemMajorNew({Key key, this.universityName, this.facultyName, this.major}) : super(key: key);

  @override
  _ItemMajorNewState createState() => _ItemMajorNewState();
}

class _ItemMajorNewState extends State<ItemMajorNew> {
  @override
  Widget build(BuildContext context) {
    final Major itemMajor = Major.fromJson(widget.major.data);
    return SafeArea(
      child: Scaffold(
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
                        UIdata.txItemMajorTitle,
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
            child: Column(
              children: <Widget>[
                Padding(
                   padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                   child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
 Text(itemMajor.majorName,style: UIdata.textTitleStyleDarkBold27,),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.facultyName,style: UIdata.textTitleStyleDark,),
                Text(widget.universityName,style: UIdata.textTitleStyleDarkUninersity,)
                      ],
                    ),
                    SizedBox(
                          width: 50,
                        ),
                    Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.red),
                        color: Colors.white
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          Icon(
                            FontAwesomeIcons.heart,
                            color: Colors.red,
                            size: 25,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'ติดตามสาขา'
                            ,style: TextStyle(fontSize: 14,color: Colors.red),
                          )
                        ],),
                    )
                  ],
                ),
                 SizedBox(height: 15,),
              Row(
                children: <Widget>[
                  Text('รอบที่เปิดรับ',style:TextStyle(color: Color(0xffFF9211),fontSize: 15),),
                SizedBox(width: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: roundTcas(true,'1'),
                    ),
                       Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: roundTcas(true,'2'),
                    ),
                      Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: roundTcas(false,'3'),
                    ),
                      Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: roundTcas(false,'4'),
                    ),
                      Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: roundTcas(false,'5'),
                    ),
                  ],
                )
                ],
              ),
               SizedBox(height: 15,),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                       Text('วุฒิการศึกษา',style:TextStyle(color: Color(0xffFF9211),fontSize: 15),),
                       Text('- '+itemMajor.certificate,style: TextStyle(color: Color(0xff939191),fontSize: 14,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(
                    width: 80,
                  ),
                     Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                       Text('ระยะเวลาหลักสูตร',style:TextStyle(color: Color(0xffFF9211),fontSize: 15),),
                       Text('- '+itemMajor.courseDuration+' ปี',style: TextStyle(color: Color(0xff939191),fontSize: 14,fontWeight: FontWeight.bold),)
                    ],
                  )
                ],
              ),
              SizedBox(height: 15,),
               Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                       Text('ค่าเทอม',style:TextStyle(color: Color(0xffFF9211),fontSize: 15),),
                       Text('- '+itemMajor.tuitionFee+' / ภาคเรียน',style: TextStyle(color: Color(0xff939191),fontSize: 14,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(width: 110),
                    Text('ดูเพิ่มเติมเกี่ยวกับสาขา',style: TextStyle(color: Color(0xff939191),fontSize: 13),)
                ],
              ),
                     ],
                   ),
                ),
               
              SizedBox(height: 5,),
             Container(
               width: MediaQuery.of(context).size.width,
               height: 7,
               decoration: BoxDecoration(
                 color: Color(0xffEBEBEB)
               ),
             )
              ],
            ),
            ),
      ),
      
    );
  }
  Widget roundTcas(bool isOpen,String number){
    return  Container(
      alignment: Alignment.center,
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isOpen == true ? Color(0xff006A82) : Color(0xff00BAE3)
                      ),
                      child: Text(number,style: TextStyle(color: isOpen == true ?Colors.white: Colors.black,fontSize: 14),),
                    );
  }
}