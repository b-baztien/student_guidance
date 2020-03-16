class EntranceExamResult {
  String entranceExamName;
  String round;
  String year;
  String university;
  String faculty;
  String major;
  String schoolName;
  EntranceExamResult(
      {this.entranceExamName,
      this.round,
      this.year,
      this.university,
      this.faculty,
      this.major,
      this.schoolName});
  Map toMap() {
    var map = Map<String, dynamic>();
    map['entrance_exam_name'] = entranceExamName;
    map['year'] = year;
    map['university'] = university;
    map['faculty'] = faculty;
    map['major'] = major;
    map['schoolName'] = schoolName;
    return map;
  }

  factory EntranceExamResult.fromJson(Map<String, dynamic> json) {
    return EntranceExamResult(
      entranceExamName: json['entrance_exam_name'] as String,
      year: json['year'] as String,
      university: json['university'] as String,
      faculty: json['faculty'] as String,
      major: json['major'] as String,
      schoolName: json['schoolName'] as String,
    );
  }
}
