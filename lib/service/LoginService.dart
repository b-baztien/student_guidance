import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/utils/ServiceData.dart';

class LoginService {
  // Future<String> login({Map body}) async {
  //   final response = await http.get(DataService.url + '/test/');

  //   print(response.body);

  //   return response.body;
  // }

  Future<Login> login({Map body}) async {
    String url = ServiceData.url + '/login/';
    final response = await http.post(
      url,
      headers: ServiceData.headers,
      body: json.encode(body),
      encoding: ServiceData.encoding,
    );

    if (response.statusCode == 200) {
      Login login = Login.fromJson(json.decode(response.body));
      return login;
    } else {
      throw Exception(
          'ชื่อผู้ใช้ หรือ รหัสผ่านไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง');
    }
  }
}
