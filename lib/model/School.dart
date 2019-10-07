class School{
  String schoolName;

  School({
    this.schoolName
  });
  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      schoolName: json['school_name'],
    );
  }
}