class University{
  String universityname;
  String address;
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
      ,this.faculty
    }
  );
  factory University.fromJson(Map<String, dynamic> json) {
    
    return University(
      universityname: json['university_name'] as String,
      address: json['address'] as String,
      url: json['url'] as String,
      phoneNO: json['phone_no'] as String,
      universitydetail: json['university_detail'] as String,
      zone: json['zone'] as String,
      view: json['view'] as int,
      image: json['image'] as String,
      faculty: json['faculty'] as List<dynamic>,
    );
  }

  
}

