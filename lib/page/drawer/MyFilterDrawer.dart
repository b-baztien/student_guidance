import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:student_guidance/utils/UIdata.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class MyFilterDrawer extends StatefulWidget {

  @override
  _MyFilterDrawerState createState() => _MyFilterDrawerState();
}

class _MyFilterDrawerState extends State<MyFilterDrawer> {
  int groupRadio = 1;
  List<Color> list = [Colors.green,Colors.black,Colors.blue,Colors.deepOrange];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
            color: Colors.white, boxShadow: [BoxShadow(color: Colors.black45)]),
        width: 300,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                UIdata.tx_filtter_title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(UIdata.tx_filter_type),
              itemFilter(UIdata.tx_filter_item_university,1),
              _buildDivider(),
              itemFilter(UIdata.tx_filter_item_faculty,2),
              _buildDivider(),
              itemFilter(UIdata.tx_filter_item_major,3),
              _buildDivider(),
              itemFilter(UIdata.tx_filter_item_career,4),
              SizedBox(
                height: 40,
              ),
              Text(
                UIdata.tx_filter_recommend,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              itemRecommend(),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.green,
                          child: Text(
                            UIdata.bt_filtter_success,
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              print('okayyyy');
                            });
                          },
                        ),
                        RaisedButton(
                          child: Text(UIdata.bt_filtter_close),
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                              print('Close');
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemFilter(String txTypeFilter,int value) {
  
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text(txTypeFilter), 
        Radio(value: value,
         groupValue: groupRadio,
          activeColor: Colors.pink,
          onChanged: (T){
            print(T);
            setState(() {
              groupRadio = T;
            });
          })
        
        ],
      ),
    );
  }
  Divider _buildDivider() {
    return Divider(
      color: Colors.indigo,
    );
  }
  Widget itemRecommend(){
    return Container(
      height: 150,

      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: DiagonalPathClipperOne(),
            child: Container(height: 140,
              color: Colors.deepPurple,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Swiper(

              autoplay: true,
              itemBuilder: (BuildContext context,int index){
                print(index);
                return Container(
                  decoration: BoxDecoration(
                      color: list[index]
                  ),
                );
              },
              itemCount: list.length,
              pagination: new SwiperPagination(),
            ),
          )
        ],
      )
    );
  }
}
