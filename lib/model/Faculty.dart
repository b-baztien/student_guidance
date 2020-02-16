class FacultyIcon {
  String codePoint;
  String fontFamily;
  String name;
}

class Faculty {
  FacultyIcon facultyIcon;
  String facultyName;
  String url;
  Faculty({this.facultyIcon, this.facultyName, this.url});
  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      // facultyIcon: json['facultyIcon'] as FacultyIcon,
      facultyName: json['faculty_name'] as String,
      url: json['url'] as String,
    );
  }
}
