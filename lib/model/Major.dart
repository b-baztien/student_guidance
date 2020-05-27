class Major {
  String majorName;
  String url;
  String certificate;
  List<String> listCareerName;
  String courseDuration;
  String tuitionFee;

  List<dynamic> albumImage;
  Major({
    this.majorName,
    this.url,
    this.listCareerName,
    this.certificate,
    this.courseDuration,
    this.tuitionFee,
    this.albumImage
  });

  factory Major.fromJson(Map<String, dynamic> json) {
    return Major(
        majorName: json['majorName'] as String,
        listCareerName: (json['listCareerName'] as List)
            .map((data) => data as String)
            .toList(),
        url: json['url'] as String,
        certificate: json['certificate'] as String,
        albumImage: json['albumImage'] as  List<dynamic>,
        courseDuration: json['courseDuration'] as String,
        tuitionFee: json['tuitionFee'] as String);
  }
}
