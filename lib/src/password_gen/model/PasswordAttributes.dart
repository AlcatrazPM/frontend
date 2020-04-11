
/// models the attributes a class should have or not
class PasswordAttributes {
  bool hasLowerCase;
  bool hasUpperCase;
  bool hasNumbers;
  bool hasSpecialChars;
  String omittedChars;

  PasswordAttributes(
      {this.hasLowerCase = true,
      this.hasUpperCase = true,
      this.hasNumbers = true,
      this.hasSpecialChars = true,
      this.omittedChars = ""});
}
