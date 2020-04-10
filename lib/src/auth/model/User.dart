import 'package:alkatrazpm/src/auth/model/AuthCredentials.dart';

class User {
  AuthResponse authResponse;
  String userName;
  String email;
  User(this.email, this.userName, this.authResponse);
}
