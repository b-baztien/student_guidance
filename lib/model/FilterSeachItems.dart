import 'package:cloud_firestore/cloud_firestore.dart';

class FilterSeachItems {
  String id;
  String type;
  String name;
  String uProvince;
  String uZone;
  DocumentSnapshot documentSnapshot;
  FilterSeachItems(
      {this.id,
      this.name,
      this.type,
      this.documentSnapshot,
      this.uProvince,
      this.uZone});
}
