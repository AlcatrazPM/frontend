import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:alkatrazpm/src/accounts/model/Account.dart';
import 'package:alkatrazpm/src/crypto/KeysEncryption.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/export.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class KeysEncryptionDefault implements KeysEncryption {
  @override
  Future<Account> decryptEntry(Account entry, String DEK) async {
    String site;
    String user;
    String pass;
    site = await decrypt(entry.website, DEK, "false");
    user = await decrypt(entry.username, DEK, "false");
    pass = await decrypt(entry.password, DEK, "false");

    // return Future.value(entry);
   return Future.value(
    new Account(
      id: entry.id,
      website: site,
      username: user,
      password: pass,
      isFavorite: entry.isFavorite));
  }

  @override
  Future<Account> encryptEntry(Account entry, String DEK) async {
    String site;
    String user;
    String pass;

   site = await encrypt(entry.website, DEK, "false");
   user = await encrypt(entry.username, DEK, "false");
   pass = await encrypt(entry.password, DEK, "false");

    // return Future.value(entry);
   return Future.value(
     new Account(
      id: entry.id,
      website: site,
      username: user,
      password: pass,
      isFavorite: entry.isFavorite));
  }

  @override
  Future<List<Account>> decryptAll(List<Account> entries, String DEK) async {
    var res = List<Account>(entries.length);
    int i = 0;
    for (Account a in entries) {
      res[i] = await decryptEntry(a, DEK);
      i++;
    }
    return Future.value(res);
  }

  @override
  Future<String> generateDataEncryptionKey() async {
    return compute(_generateDataEncryptionKey, 1);
  }

  @override
  Future<String> encrypt(String value, String key, String isBase64) async {
    return compute(_encrypt, [value, key, isBase64]);
  }

  @override
  Future<String> decrypt(String value, String key, String toBase64) async {
    return compute(_decrypt, [value, key, toBase64]);
  }

  @override
  Future<String> generateKEKSalt() async {
    var salt = _getRandomBytes(32);
    return Future.value(base64.encode(salt));
  }

  @override
  Future<String> generateKeyEncryptionKey(String password, String salt) async {
    return compute(_generateKeyEncryptionKey, [password, salt]);
  }

  @override
  Future<String> passwordHash(String password, int iterations) async {
    return compute(_passwordHash, [password, iterations]);
  }

  List<int> _getRandomBytes(int numBytes) {
    Random rand = new Random.secure();
    return List<int>.generate(numBytes, (i) => rand.nextInt(256));
  }


}

Uint8List _pad(Uint8List src, int blockSize) {
  var pad = new PKCS7Padding();
  pad.init(null);

  int padLength = blockSize - (src.length % blockSize);
  var out = new Uint8List(src.length + padLength)..setAll(0, src);
  pad.addPadding(out, src.length);

  return out;
}

Uint8List _unpad(Uint8List src) {
  var pad = new PKCS7Padding();
  pad.init(null);

  int padLength = pad.padCount(src);
  int len = src.length - padLength;

  return new Uint8List(len)..setRange(0, len, src);
}

Uint8List _processBlocks(BlockCipher cipher, Uint8List inp) {
  var out = new Uint8List(inp.lengthInBytes);

  for (var offset = 0; offset < inp.lengthInBytes;) {
    var len = cipher.processBlock(inp, offset, out, offset);
    offset += len;
  }

  return out;
}

List<int> _getRandomBytes(int numBytes) {
  Random rand = new Random.secure();
  return List<int>.generate(numBytes, (i) => rand.nextInt(256));
}

String _generateDataEncryptionKey(int) {
  var DEK = Uint8List(32);
  var base = _getRandomBytes(16);
  var salt = _getRandomBytes(16);

  KeyDerivator kd = new KeyDerivator("SHA-1/HMAC/PBKDF2");
  kd.init(new Pbkdf2Parameters(Uint8List.fromList(salt), 100000, 32));
  kd.deriveKey(Uint8List.fromList(base), 0, DEK, 0);
  return base64.encode(DEK);
}

void pop(){

}


String _encrypt(List<String> s) {
  var key = s[1];
  var value = s[0];
  bool isBase64 = s[2] == "true" ? true : false;

  var valueBytes = isBase64 
    ? base64.decode(value) 
    : value.codeUnits.map((e) => e).toList();
  var keyBytes = base64.decode(key);
  KeyParameter keyParam = new KeyParameter(keyBytes);
  BlockCipher aes = new AESFastEngine();

  var rand = FortunaRandom();
  rand.seed(keyParam);
  var iv = rand.nextBytes(aes.blockSize);

  BlockCipher cipher = new CBCBlockCipher(aes);
  cipher.init(true, new ParametersWithIV(keyParam, iv));

  var data = _pad(valueBytes, aes.blockSize);
  var encryptedData = _processBlocks(cipher, data);
  var ivEncryptedData = new Uint8List(encryptedData.length + iv.length)
    ..setAll(0, iv)
    ..setAll(iv.length, encryptedData);

  return base64.encode(ivEncryptedData);
}

String _decrypt(List<String> params) {
  var key = params[1];
  var value = params[0];
  bool toBase64 = params[2] == "true" ? true : false;

  var valueBytes = base64.decode(value);
  var keyBytes = base64.decode(key);//bas


  KeyParameter keyParam = new KeyParameter(keyBytes);
  BlockCipher aes = new AESFastEngine();

  var iv = new Uint8List(aes.blockSize)..setRange(0, aes.blockSize, valueBytes);

  BlockCipher cipher = new CBCBlockCipher(aes);
  cipher.init(false, new ParametersWithIV(keyParam, iv));

  int dataLength = valueBytes.length - aes.blockSize;
  Uint8List dataBytes = new Uint8List(dataLength)
    ..setRange(0, dataLength, valueBytes, aes.blockSize);

  var paddedClearData = _processBlocks(cipher, dataBytes);
  var clearData = _unpad(paddedClearData);

  return toBase64 
    ? base64.encode(clearData) 
    : new String.fromCharCodes(clearData);
}

String _generateKeyEncryptionKey(List<String> params) {
  var password = params[0];
  var salt = params[1];
  var KEK = Uint8List(32);

  var decodedSalt = Uint8List.fromList(base64.decode(salt));
  var decodedBase = Uint8List.fromList(password.codeUnits.map((e) => e).toList());

  KeyDerivator kd = new KeyDerivator("SHA-1/HMAC/PBKDF2");
  var pbkdfParams = new Pbkdf2Parameters(decodedSalt, 100000, 32);

  kd.init(pbkdfParams);
  kd.deriveKey(decodedBase, 0, KEK, 0);

  return base64.encode(KEK);
}

String _passwordHash(List<dynamic> params) {
  var password = params[0];
  var iterations = params[1];
  var bytes = utf8.encode(password);
  var hash = sha512.convert(bytes);
  for (int i = 0; i < iterations - 1; i++) {
    hash = sha512.convert(hash.bytes);
  }
  return hash.toString();
}
