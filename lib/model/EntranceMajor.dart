class EntranceMajor {
  String universityName;
  String facultyName;
  String majorName;
  String schoolName;
  String entranceYear;

  EntranceMajor(
      {this.universityName,
      this.facultyName,
      this.majorName,
      this.schoolName,
      this.entranceYear});

  Map toMap() {
    var map = Map<String, dynamic>();
    map['universityName'] = universityName;
    map['facultyName'] = facultyName;
    map['majorName'] = majorName;
    map['schoolName'] = schoolName;
    map['entranceYear'] = entranceYear;
    return map;
  }

  factory EntranceMajor.fromJson(Map<String, dynamic> json) {
    return EntranceMajor(
      universityName: json['universityName'] as String,
      facultyName: json['facultyName'] as String,
      majorName: json['majorName'] as String,
      schoolName: json['schoolName'] as String,
      entranceYear: json['entranceYear'] as String,
    );
  }
}
