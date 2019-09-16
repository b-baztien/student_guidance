import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Login.dart';


CollectionReference ref = Firestore.instance.collection("Login");

class LoginService {
     Future<Login> login(Login user_login) async {
    try {
      DocumentReference refQuery = await ref.document(user_login.username);

      Login login = await refQuery.get().then((doc) async {
        return Login.fromJson(doc.data);
      });

      if (user_login.password == login.password) {
        return await login;
      } else {
        throw ("ชื่อผู้ใช้ หรือ รหัสผ่านไม่ถูกต้อง กรุณาลองใหม่อีกครั้งภายหลัง");
      }
    } catch (e) {
      rethrow;
    }
  }
}