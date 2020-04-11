import 'package:dart_json_mapper/dart_json_mapper.dart';

/// models the attributes a class should have or not
class PasswordAttributes {
  bool hasLowerCase;
  bool hasUpperCase;
  bool hasNumbers;
  bool hasSpecialChars;
  int minNumbers;
  int minSpecial;
  int length;

  PasswordAttributes(
      {this.hasLowerCase = true,
      this.hasUpperCase = true,
      this.hasNumbers = true,
      this.hasSpecialChars = true,
      this.minNumbers = 0,
      this.minSpecial = 0,
      this.length = 12});
}
