import 'package:cloud_firestore/cloud_firestore.dart';

class  FilterSeachItems {
  String id;
  String type;
  String name;
  DocumentSnapshot documentSnapshot;
  FilterSeachItems({this.id,this.name,this.type,this.documentSnapshot});
  
}