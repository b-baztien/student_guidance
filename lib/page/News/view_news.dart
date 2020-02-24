import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:student_guidance/model/News.dart';
import 'package:student_guidance/service/GetImageService.dart';
import 'package:student_guidance/utils/UIdata.dart';


class ViewNewsPage extends StatefulWidget {
  final News news;
  ViewNewsPage({this.news});

  @override
  _ViewNewsPage createState() => _ViewNewsPage();
}

class _ViewNewsPage extends State<ViewNewsPage> {
  final formattedDate = DateFormat('dd MMMM yyyy', 'th');
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(UIdata.txTitleDetailNews),
          centerTitle: true,
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: UIdata.backIconAndroid,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: GetImageService().getImage(
                    widget.news.image),
                builder: (context, snapImg) {
                  if (snapImg.hasData) {
                    return Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  snapImg.data),
                              fit: BoxFit.cover)),
                    );
                  } else {
                    return Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/view-news.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(formattedDate.format(widget.news.startTime.toDate())),
                        IconButton(icon: Icon(Icons.share),onPressed: (){

                        },)
                      ],
                    ),
                    Text(widget.news.topic,style: UIdata.textTitleStyleDarkBold,),
                    Divider(
                      color: Colors.red,
                    ),
                    SizedBox(height: 10),

                  Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.home),
                        SizedBox(width: 10,),
                        widget.news.listUniversityName.isNotEmpty ?
                          SingleChildScrollView(
                            child: Row(
                              children: widget.news.listUniversityName.map((univer){
                                return Text(univer+" ");
                              }).toList()
                            ),
                          )
                        :
                        Text('ไม่มีมหาวิทยาลัยเกี่ยวข้อง')
                      ],
                    ),
                    Divider(
                      color: Colors.red,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      widget.news.detail,style: UIdata.textSubTitleStyleDark,
                    )
                  ],
                ),
              )

            ],
          ),

        )
      ),
    );
  }
}
