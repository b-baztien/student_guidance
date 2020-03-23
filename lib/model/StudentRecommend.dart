class StudentRecommend {
  List<String> majorName;
  List<String> careerName;
  String username;

  StudentRecommend({this.majorName, this.careerName, this.username});

  Map toMap() {
    var map = Map<String, dynamic>();
    map['majorName'] = majorName;
    map['careerName'] = careerName;
    map['username'] = username;
    return map;
  }

  factory StudentRecommend.fromJson(Map<String, dynamic> json) {
    return StudentRecommend(
      majorName: json['majorName'] == null
          ? List<String>()
          : (json['majorName'] as List).map((data) => data as String).toList(),
      careerName: json['careerName'] == null
          ? List<String>()
          : (json['careerName'] as List).map((data) => data as String).toList(),
      username: json['username'] as String,
    );
  }
}
