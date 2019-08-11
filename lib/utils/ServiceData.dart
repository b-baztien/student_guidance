import 'dart:convert';

class ServiceData {
  //ตั้งเป็น IP ของเครื่องตัวเอง (cmd > พิมพ์คำสั่ง ipconfig)
  static String url = 'http://192.168.43.145:8080/studentguidance';
  static Map<String, String> headers = {'Content-Type': 'application/json'};
  static Encoding encoding = Encoding.getByName('utf-8');
}