import 'dart:collection';

class FacultyIcon {
  String codePoint;
  String fontFamily;
  String name;
  FacultyIcon({this.fontFamily, this.name, this.codePoint});

  factory FacultyIcon.fromJson(LinkedHashMap json) {
    return FacultyIcon(
      fontFamily: json['fontFamily'] as String,
      name: json['name'] as String,
      codePoint: json['codePoint'] as String,
    );
  }
}

class Faculty {
  FacultyIcon facultyIcon;
  String facultyName;
  String url;
  Faculty({this.facultyIcon, this.facultyName, this.url});
  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      facultyIcon: FacultyIcon.fromJson(json['facultyIcon']),
      facultyName: json['faculty_name'] as String,
      url: json['url'] as String,
    );
  }
}
