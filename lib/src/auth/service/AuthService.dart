
import 'package:alkatrazpm/src/auth/model/AuthCredentials.dart';
import 'package:alkatrazpm/src/auth/model/User.dart';

class InvalidJwtException implements Exception {
  @override
  String toString() {
    return 'Authorization token expired';
  }
}
abstract class AuthService{
  Future<User> login(AuthCredentials credentials);
  Future<void> register(AuthCredentials credentials);
  Future<void> logout();
  Future<User> loggedUser({bool doPop = true});

  Future<void> modifyMasterPassword(String oldPassword, String
  newPassword);

  Future<void> modifyEmail(String newEmail);
  Future<void> modifySessionTimer(int newTimer);
  Future<void> modifyUsername(String newUsername);
}