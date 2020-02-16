class Career {
  String careerName;
  String description;
  String image;

  Career({this.careerName, this.description, this.image});

  factory Career.fromJson(Map<String, dynamic> json) {
    return Career(
      careerName: json['career_name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
    );
  }
}
