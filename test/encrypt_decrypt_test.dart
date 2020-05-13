import 'dart:convert';

import 'package:alkatrazpm/src/accounts/model/Account.dart';
import 'package:alkatrazpm/src/crypto/KeysEncryption.dart';
import 'package:alkatrazpm/src/crypto/KeysEncryptionDefault.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alkatrazpm/main.dart';

String e_dek = "EtDimlhuRFU1mWEq0U0o2A/4tlDg45RwDYHFx9heRKOH9KS6MU2O34hdhF/zjMas";
String i_kek = "mvgUTG0W7lvH/44SLC70hfD07127+00yIFgB66UBNNo=";
String mp = "master_p";

Account encAccount = new Account(
    website: "j7sHxmM30gT1YtYdY2vvig2P41p8FaJUfNAOHK457+ogccqehnb5/5L3T99Y43ic",
    username: "/jEwNp415/6CqrLlQPUbnanFeWEl7LfUCGlF5aFB6Y4=",
    password: "7Zvr+zwR76Nu+BMkddvHYY0AVbE8v8OKjniBun9BJq4=",
    isFavorite: true);

void main() {
  test("a", () async {
    KeysEncryption ke = new KeysEncryptionDefault();

    var kek = ke.generateKeyEncryptionKey(mp, i_kek);
    var dek = ke.decrypt(e_dek, await kek);

    print(base64.decode(await dek));

    Account decAccount = await ke.decryptEntry(encAccount, await dek);

    print(decAccount.toJson());
  });

  test("b", () async {
    KeysEncryption ke = new KeysEncryptionDefault();

    var kek = ke.generateKeyEncryptionKey("password", await ke.generateKEKSalt());
    var dek = ke.generateDataEncryptionKey();

    print(await dek);

    var enc_dek = ke.encrypt(await dek, await kek);
    var dek2 = ke.decrypt(await enc_dek, await kek);

    print(await dek2);

  });
}
