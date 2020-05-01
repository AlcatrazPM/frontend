import 'dart:convert';

import 'package:alkatrazpm/src/crypto/KeysEncryption.dart';
import 'package:crypto/crypto.dart';


class KeysEncryptionDefault implements KeysEncryption{
  @override
  Future<String> dataEncryptionKey() {
    return Future.value("dsmsd ksglk");
  }

  @override
  Future<String> keyEncryptionKey(String password) {
    return Future.value("dfgfgdf");
  }

  @override
  Future<String> passwordHash(String password, int iterations) {
    var bytes = utf8.encode(password);
    var hash = sha512.convert(bytes);
    for (int i = 0; i < iterations - 1; i++) {
      hash = sha512.convert(hash.bytes);
    }
    return Future.value(hash.toString());
  }

}

