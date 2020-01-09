class EntranceExamResult {
  String entrance_exam_name;
  String round;
  String year;
  String university;
  String faculty;
  String major;
  EntranceExamResult(
      {this.entrance_exam_name,
      this.round,
      this.year,
      this.university,
      this.faculty,
      this.major,});
  Map toMap() {
    var map = Map<String, dynamic>();
    map['entrance_exam_name'] = entrance_exam_name;
    map['year'] = year;
    map['university'] = university;
    map['faculty'] = faculty;
    map['major'] = major;
    return map;
  }

  factory EntranceExamResult.fromJson(Map<String, dynamic> json) {
    return EntranceExamResult(
      entrance_exam_name: json['entrance_exam_name'] as String,
      year: json['year'] as String,
      university: json['university'] as String,
      faculty: json['faculty'] as String,
      major: json['major'] as String,
    );
  }
}
