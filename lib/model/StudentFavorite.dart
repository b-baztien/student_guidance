class StudentFavorite {
  String university;
  String faculty;
  String major;
  String username;

  StudentFavorite({this.university, this.faculty, this.major, this.username});

  Map toMap() {
    var map = Map<String, dynamic>();
    map['university'] = university;
    map['faculty'] = faculty;
    map['major'] = major;
    map['username'] = username;
    return map;
  }

  factory StudentFavorite.fromJson(Map<String, dynamic> json) {
    return StudentFavorite(
      university: json['university'] as String,
      faculty: json['faculty'] as String,
      major: json['major'] as String,
      username: json['schoolName'] as String,
    );
  }
}
