import 'package:alkatrazpm/src/auth/model/AuthCredentials.dart';

class User {
  AuthResponse authResponse;
  String email;
  User(this.email, this.authResponse);
}
