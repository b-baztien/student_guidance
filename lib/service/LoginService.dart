import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/utils/ServiceData.dart';

class LoginService {
  Future<Login> login({Map body}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String url = ServiceData.url + '/login/';
    final response = await http.post(
      url,
      headers: ServiceData.headers,
      body: json.encode(body),
      encoding: ServiceData.encoding,
    );

    if (response.statusCode == 200) {
      Login login = Login.fromJson(
        json.decode(response.body),
      );
      sharedPreferences.setString(
        'user',
        json.encode(body),
      );
      return login;
    } else {
      throw new Exception(
        json.decode(response.body),
      );
    }
  }
}