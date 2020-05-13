import 'dart:math';

import 'package:alkatrazpm/src/password_gen/model/PasswordAttributes.dart';
import 'package:alkatrazpm/src/password_gen/service/PasswordGen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordGenDefault implements PasswordGen {

  static const String _LENGTH = "pg_LENGTH";
  static const String _LOWER = "pg_lower";
  static const String _UPPER = "pg_upper";
  static const String _SPECIAL = "pg_special";
  static const String _NUM = "pg_num";
  static const String _MIN_NUM = "pg_min_num";
  static const String _MIN_SPECIAL = "pg_min_special";

  String upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String lower = "abcdefghijklmnopqrstuvwxyz";
  String numbers = "0123456789";
  String specials = "!@#\$%^&*()_+-=`~[]{}|;:,./<>?\\";
  @override
  Future<PasswordAttributes> getAttributes() async{
    var attribs = PasswordAttributes();
    var sharedPref = await SharedPreferences.getInstance();
    attribs.length = sharedPref.getInt(_LENGTH);
    attribs.hasLowerCase = sharedPref.getBool(_LOWER);
    attribs.hasUpperCase = sharedPref.getBool(_UPPER);
    attribs.hasNumbers = sharedPref.getBool(_NUM);
    attribs.hasSpecialChars = sharedPref.getBool(_SPECIAL);
    attribs.minSpecial = sharedPref.getInt(_MIN_SPECIAL);
    attribs.minNumbers = sharedPref.getInt(_MIN_NUM);
    return Future.value(attribs);
  }

  @override
  Future<void> saveAttributes(PasswordAttributes attributes) async{
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setInt(_LENGTH, attributes.length);
    sharedPref.setBool(_LOWER, attributes.hasLowerCase);
    sharedPref.setBool(_UPPER, attributes.hasUpperCase);
    sharedPref.setBool(_SPECIAL, attributes.hasSpecialChars);
    sharedPref.setBool(_NUM, attributes.hasNumbers);
    sharedPref.setInt(_MIN_NUM, attributes.minNumbers);
    sharedPref.setInt(_MIN_SPECIAL, attributes.minSpecial);
  }

  static Random _rand;


  String genPassword(PasswordAttributes attributes) {
    if (attributes.minSpecial + attributes.minNumbers > attributes.length)
      throw IllegalLengthException();

    String choice = (attributes.hasUpperCase ? upper : "") +
        (attributes.hasLowerCase ? lower : "") +
        (attributes.hasNumbers ? numbers : "") +
        (attributes.hasSpecialChars ? specials : "");

    if (choice == "") throw NoPasswordBaseException();

    _rand = new Random();

    List<String> pass = (' ' * attributes.length).split('');

    int length = attributes.length;

    if (attributes.hasNumbers)
      for (int i = 0; i < attributes.minNumbers; i++) {
        pass[_getNextIdx(pass)] = numbers[_rand.nextInt(numbers.length)];
        length--;
      }

    if (attributes.hasSpecialChars)
      for (int i = 0; i < attributes.minSpecial; i++) {
        pass[_getNextIdx(pass)] = specials[_rand.nextInt(specials.length)];
        length--;
      }

    for (int i = 0; i < length; i++) {
      pass[_getNextIdx(pass)] = choice[_rand.nextInt(choice.length)];
    }

    return pass.join();
  }

  static int _getNextIdx(List<String> pass) {
    int idx;
    Random rand = Random();

    do {
      idx = rand.nextInt(pass.length);
    } while (pass[idx] != ' ');

    return idx;
  }

  @override
  Future<String> generatePassword() async{
    var attribs = await getAttributes();
    var password = genPassword(attribs);
    return Future.value(password);
  }


}
