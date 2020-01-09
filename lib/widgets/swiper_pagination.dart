import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CustomePaginationBuilder extends SwiperPlugin{
  final Color activeColor;
  final Color color;
  final Size activeSize;
  final Size size;
  final double space;
  final Key key;
  const CustomePaginationBuilder({
    this.activeColor,
    this.activeSize:const Size(10.0,2.0),
    this.color,
    this.key,
    this.size : const Size(10.0,2.0),
    this.space : 3.0
});
  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {


    ThemeData themeData = Theme.of(context);
    Color activeColor = this.activeColor ?? themeData.primaryColor;
    Color color = this.color ?? themeData.scaffoldBackgroundColor;
    List<Widget> list = [];
    int itemCount = config.itemCount;
    int activeIndex = config.activeIndex;
    for(int i=0;i<itemCount;i++){
      bool active = i == activeIndex;
      Size size = active ? this.activeSize : this.size;
      list.add(SizedBox(
        width: size.width,
        height: size.height,
        child: Container(
          decoration: BoxDecoration(
            color: active ? activeColor : color,
            borderRadius : BorderRadius.circular(10.0)
          ),
          key: Key("page_$i"),
          margin: EdgeInsets.all(space),
        ),
      ));
    }
    if(config.scrollDirection == Axis.vertical){
      return Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    }else{
      return Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    }
    // TODO: implement build
    return null;
  }
}