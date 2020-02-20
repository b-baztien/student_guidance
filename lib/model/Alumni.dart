class Alumni {
  String graduateYear;
  String job;
  String schoolName;
  String status;

  Alumni({this.graduateYear, this.job, this.schoolName, this.status});

  factory Alumni.fromJson(Map<String, dynamic> json) {
    return Alumni(
      graduateYear: json['graduate_year'] as String,
      job: json['job'] as String,
      schoolName: json['schoolName'] as String,
      status: json['status'] as String,
    );
  }
}
