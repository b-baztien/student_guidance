class Major {
  String majorName;
  String url;
  String detail;
  String certificate;
  String degree;
  List<String> listCareerName;

  List<dynamic> albumImage;
  Major(
      {this.majorName,
      this.url,
      this.detail,
      this.listCareerName,
      this.certificate,
      this.degree,
      this.albumImage});

  factory Major.fromJson(Map<String, dynamic> json) {
    return Major(
      majorName: json['majorName'] as String,
      listCareerName: (json['listCareerName'] as List)
          .map((data) => data as String)
          .toList(),
      url: json['url'] as String,
      detail: json['detail'] == null ? 'ไม่ได้ระบุ' : json['detail'] as String,
      certificate: json['certificate'] as String,
      degree: json['degree'] == null ? 'ไม่ได้ระบุ' : json['degree'] as String,
      albumImage: json['albumImage'] as List<dynamic>,
    );
  }
}
