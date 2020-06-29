class Alumni {
  String graduateYear;
  String job;
  String schoolName;
  String status;
  String username;

  Alumni({
    this.graduateYear,
    this.job,
    this.schoolName,
    this.status,
    this.username,
  });

  Map toMap() {
    var map = Map<String, dynamic>();
    map['graduate_year'] = graduateYear;
    map['job'] = job;
    map['schoolName'] = schoolName;
    map['status'] = status;
    map['username'] = username;
    return map;
  }

  factory Alumni.fromJson(Map<String, dynamic> json) {
    return Alumni(
      graduateYear: json['graduate_year'] as String,
      job: json['job'] as String,
      schoolName: json['schoolName'] as String,
      status: json['status'] as String,
      username: json['username'] as String,
    );
  }
}
