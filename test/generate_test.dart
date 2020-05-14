import 'package:alkatrazpm/src/password_gen/model/PasswordAttributes.dart';
import 'package:alkatrazpm/src/password_gen/service/PasswordGen.dart';
import 'package:alkatrazpm/src/password_gen/service/PasswordGenDefault.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Illegal length", () {
    PasswordAttributes attributes = PasswordAttributes(minNumbers: 20, length: 15);
    
    expect(() => PasswordGenDefault().genPassword(attributes), throwsA
      (isA<IllegalLengthException>()));

    attributes.minSpecial = 5;
    attributes.minNumbers = 11;
    expect(() => PasswordGenDefault().genPassword(attributes), throwsA(isA<IllegalLengthException>()));
  });

  test("No Base", () {
    PasswordAttributes attributes = PasswordAttributes(hasLowerCase: false, hasUpperCase: false, hasNumbers: false, hasSpecialChars: false);

    expect(() => PasswordGenDefault().genPassword(attributes), throwsA(isA<NoPasswordBaseException>()));
  });

  test("Length", () {
    PasswordAttributes attributes = PasswordAttributes(length: 16);

    String pass = PasswordGenDefault().genPassword(attributes);
    print(pass);

    assert(pass.length == 16);
  });

  test("No lowercase", () {
    PasswordAttributes attributes = PasswordAttributes(hasLowerCase: false);

    String pass = PasswordGenDefault().genPassword(attributes);
    print(pass);

    assert(pass == pass.toUpperCase());
  });

  test("No uppercase", () {
    PasswordAttributes attributes = PasswordAttributes(hasUpperCase: false);

    String pass = PasswordGenDefault().genPassword(attributes);
    print(pass);

    assert(pass == pass.toLowerCase());
  });

  test("No special", () {
    PasswordAttributes attributes = PasswordAttributes(hasSpecialChars: false);

    String pass = PasswordGenDefault().genPassword(attributes);
    print(pass);

    pass.split('').forEach((element) {assert(!PasswordGenDefault().specials.contains(element));});
  });

  test("No numbers", () {
    PasswordAttributes attributes = PasswordAttributes(hasNumbers: false);

    String pass = PasswordGenDefault().genPassword(attributes);
    print(pass);

    pass.split('').forEach((element) {assert(!PasswordGenDefault().numbers.contains(element));});
  });

  test("Min special", () {
    PasswordAttributes attributes = PasswordAttributes(minSpecial: 5);

    String pass = PasswordGenDefault().genPassword(attributes);
    print(pass);

    assert(pass.split('').where((element) => PasswordGenDefault().specials.contains(element)).length >= 5);
  });

  test("Min numbers", () {
    PasswordAttributes attributes = PasswordAttributes(minNumbers: 5);

    String pass = PasswordGenDefault().genPassword(attributes);
    print(pass);

    assert(pass.split('').where((element) => PasswordGenDefault().numbers.contains
      (element)).length >= 5);
  });

  test("Min special + numbers", () {
    PasswordAttributes attributes = PasswordAttributes(minSpecial: 5, minNumbers: 5);

    String pass = PasswordGenDefault().genPassword(attributes);
    print(pass);
    assert(pass.split('').where((element) {
      return PasswordGenDefault().specials.contains(element)
        || PasswordGenDefault().numbers.contains(element);
    }).length >= 10);
  });
}