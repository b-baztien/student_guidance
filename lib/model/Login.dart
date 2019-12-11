class Login {
  String username;
  String password;
  String type;

  Login({this.username, this.password, this.type});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      username: json['username'],
      password: json['password'],
      type: json['type'],
    );
  }

  Map toMap() {
    var map = Map<String, dynamic>();
    map['username'] = username;
    map['password'] = password;
    map['type'] = type;

    return map;
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'type': type,
      };
}
