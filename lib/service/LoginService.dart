import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/Login.dart';

final CollectionReference loginCollection = Firestore.instance.collection('Login');
class LoginService {
 final databaseReference = Firestore.instance;
  static final LoginService _instance = new LoginService.internal();
  factory LoginService() => _instance;
  LoginService.internal();

 Future<Login> getLogin(Login login) async {
   Login logins = new Login();
  loginCollection.document(login.username).get().then((DocumentSnapshot ds){
    if(ds.data.isNotEmpty){
      logins.username = ds['username'];
      logins.password = ds['password'];
      logins.type = ds['type'];
      
    }
      
  });
   
   return logins;
 }
}