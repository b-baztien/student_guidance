import 'package:google_maps_flutter/google_maps_flutter.dart';
class University{
  String universityname;
  String address;
  String url;
  String phoneNO;
  String universitydetail;
  String zone;
  int view;
  String image;
  
  University(
    {
      this.universityname,this.address,this.phoneNO,this.universitydetail,this.url,this.view,this.zone,this.image
    }
  );
  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      universityname: json['university_name'],
      address: json['address'],
      url: json['url'],
      phoneNO: json['phone_no'],
      universitydetail: json['university_detail'],
      zone: json['zone'],
        view: json['view'],
         image: json['image'],
     
    );
  }

  Map toMap() {
    var map = Map<String, dynamic>();
    map['university_name'] = universityname;
    map['password'] = address;
    map['type'] = url;
 
    return map;
  }
}

