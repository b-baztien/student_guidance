class University{
  String universityname;
  String address;

  String province;
  String tambon;
  String amphur;
  String zipcode;
  List<dynamic> highlight;
  List<dynamic> albumImage; 
  String url;
  String phoneNO;
  String universitydetail;
  String zone;
  int view;
  String image;
  List<dynamic> faculty;
  University(
    {
      this.universityname,this.address,this.phoneNO,this.universitydetail,this.url,this.view,this.zone,this.image
      ,this.faculty,this.province,this.amphur,this.tambon,this.zipcode,this.albumImage,this.highlight
    }
  );
  factory University.fromJson(Map<String, dynamic> json) {
    
    return University(
      universityname: json['university_name'] as String,
      address: json['address'] as String,
      url: json['url'] as String,
      phoneNO: json['phone_no'] as String,
       province: json['province'] as String,
        tambon: json['tambon'] as String,
         amphur: json['amphur'] as String,
         highlight: json['highlight'] as  List<dynamic>,
          albumImage: json['albumImage'] as  List<dynamic>,
          zipcode: json['zipcode'] as String,
      universitydetail: json['university_detail'] as String,
      zone: json['zone'] as String,
      view: json['view'] as int,
      image: json['image'] as String,
      faculty: json['faculty'] as List<dynamic>,
    );
  }

  
}

