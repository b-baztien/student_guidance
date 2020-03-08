import 'dart:collection';

class Tcas {
  String round;
  String description;
  List<String> examReference;

  Tcas({this.round, this.description, this.examReference});

  factory Tcas.fromJson(LinkedHashMap json) {
    return Tcas(
      round: json['round'] as String,
      description: json['description'] as String,
      examReference: (json['examReference'] as List)
          .map((data) => data as String)
          .toList(),
    );
  }
}

class Major {
  String majorName;
  String url;
  List<Tcas> tcasEntranceRound;
  String certificate;
  List<String> listCareerName;
  String courseDuration;
  String tuitionFee;

  Major({
    this.majorName,
    this.url,
    this.tcasEntranceRound,
    this.listCareerName,
    this.certificate,
    this.courseDuration,
    this.tuitionFee,
  });

  factory Major.fromJson(Map<String, dynamic> json) {
    return Major(
        majorName: json['majorName'] as String,
        tcasEntranceRound: (json['tcasEntranceRound'] as List)
            .map((tcas) => Tcas.fromJson(tcas))
            .toList(),
        listCareerName: (json['listCareerName'] as List)
            .map((data) => data as String)
            .toList(),
        url: json['url'] as String,
        certificate: json['certificate'] as String,
        courseDuration: json['courseDuration'] as String,
        tuitionFee: json['tuitionFee'] as String);
  }
}
