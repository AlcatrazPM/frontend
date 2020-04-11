
import 'package:alkatrazpm/src/auth/model/AuthCredentials.dart';
import 'package:alkatrazpm/src/auth/model/User.dart';

abstract class AuthService{
  Future<User> login(AuthCredentials credentials);
  Future<User> register(AuthCredentials credentials);
  Future<User> loggedUser();
}