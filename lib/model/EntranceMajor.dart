class EntranceMajor {
  String universityName;
  String facultyName;
  String majorName;
  EntranceMajor({this.universityName, this.facultyName, this.majorName});
  Map toMap() {
    var map = Map<String, dynamic>();
    map['universityName'] = universityName;
    map['facultyName'] = facultyName;
    map['majorName'] = majorName;
    return map;
  }

  factory EntranceMajor.fromJson(Map<String, dynamic> json) {
    return EntranceMajor(
      universityName: json['universityName'] as String,
      facultyName: json['facultyName'] as String,
      majorName: json['majorName'] as String,
    );
  }
}
