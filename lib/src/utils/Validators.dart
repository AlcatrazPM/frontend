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
  static String websiteValidator(String value){
    if(value == "")
      return "website must not be empty";
    var formatError = "not a valid website format";
    if(!value.contains("."))
      return formatError;
    if(!value.contains("www."))
      return "website must start with www";
    return null;
  }

}