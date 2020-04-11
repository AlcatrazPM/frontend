typedef String Validator(String);

class Validators{
  static String emailValidator(String value){
    if(value == "")
      return "email must not be empty";
    String error = "Not a valid email";
    if(!value.contains("@"))
      return error;
    return null;
  }
  static String passwordValidator(String value){
    if(value == "")
      return "password must not be empty";
    if(value.length < 8)
      return "Password too short";
    return null;
  }
  static String usernameValidator(String value){
    if(value == "")
      return "username must not be empty";
    return null;
  }

}