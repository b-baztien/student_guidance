class Career{
  String career_name;
  List<dynamic> major;
  String description;
  String image;

  Career({
  this.career_name,this.major,this.description,this.image
  });
  
  factory Career.fromJson(Map<String, dynamic> json) {
    return Career(
     career_name: json['career_name'] as String,
      description: json['description'] as String,
       image: json['image'] as String,
      major: json['major'] as List<dynamic>,
    );
  }
}