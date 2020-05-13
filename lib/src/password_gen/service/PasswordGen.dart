import 'package:alkatrazpm/src/password_gen/model/PasswordAttributes.dart';

class NoPasswordBaseException implements Exception {
  @override
  String toString() {
    return 'Character pool for password generation cannot be empty';
  }
}

class IllegalLengthException implements Exception {
  @override
  String toString() {
    return 'Length should be at least the sum of the minimum restrictions';
  }
}

abstract class PasswordGen {


  Future<void> saveAttributes(PasswordAttributes attributes);

  Future<PasswordAttributes> getAttributes();

  Future<String> generatePassword();

  String genPassword(PasswordAttributes attributes);
}
