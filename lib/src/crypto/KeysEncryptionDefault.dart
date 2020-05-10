import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:alkatrazpm/src/accounts/model/Account.dart';
import 'package:alkatrazpm/src/crypto/KeysEncryption.dart';
import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';


class KeysEncryptionDefault implements KeysEncryption {
  List<int> _getRandomBytes(int numBytes) {
    Random rand = new Random.secure();
    return List<int>.generate(numBytes, (i) => rand.nextInt(256));
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

  @override
  Future<String> generateDataEncryptionKey() {
    var DEK = Uint8List(32);

    var base = _getRandomBytes(16);
    var salt = _getRandomBytes(16);

    KeyDerivator kd = new KeyDerivator("SHA-1/HMAC/PBKDF2");
    kd.init(new Pbkdf2Parameters(Uint8List.fromList(salt), 100000, 32));
    kd.deriveKey(Uint8List.fromList(base), 0, DEK, 0);

    return Future.value(base64.encode(DEK));
  }

  @override
  Future<String> encrypt(String value, String key) {
    var valueBytes = base64.decode(value);
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

    return Future.value(base64.encode(ivEncryptedData));
  }

  @override
  Future<String> decrypt(String value, String key) {
    var valueBytes = base64.decode(value);
    var keyBytes = base64.decode(key);

    print(keyBytes);

    KeyParameter keyParam = new KeyParameter(keyBytes);
    BlockCipher aes = new AESFastEngine();

    var iv = new Uint8List(aes.blockSize)
      ..setRange(0, aes.blockSize, valueBytes);

    print(iv);

    BlockCipher cipher = new CBCBlockCipher(aes);
    cipher.init(false, new ParametersWithIV(keyParam, iv));

    int dataLength = valueBytes.length - aes.blockSize;
    Uint8List dataBytes = new Uint8List(dataLength)
      ..setRange(0, dataLength, valueBytes, aes.blockSize);

    print(dataBytes);

    var paddedClearData = _processBlocks(cipher, dataBytes);
    var clearData = paddedClearData;
//    if (paddedClearData.length % aes.blockSize != 0) {
      clearData = _unpad(paddedClearData);
//    }

    print(clearData);

    return Future.value(base64.encode(clearData));
  }

  @override
  Future<String> generateKEKSalt() {
    var salt = _getRandomBytes(32);

    return Future.value(base64.encode(salt));
  }

  @override
  Future<String> generateKeyEncryptionKey(String password, String salt) {
    var KEK = Uint8List(32);

    var decodedSalt = Uint8List.fromList(base64.decode(salt));
    var decodedBase = Uint8List.fromList(password.codeUnits);

    KeyDerivator kd = new KeyDerivator("SHA-1/HMAC/PBKDF2");
    var pbkdfParams = new Pbkdf2Parameters(decodedSalt, 100000, 32);
    
    kd.init(pbkdfParams);
    kd.deriveKey(decodedBase, 0, KEK, 0);

    return Future.value(base64.encode(KEK));
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

  @override
  Future<Account> decryptEntry(Account entry, String DEK) async {
    String site;
    String user;
    String pass;

    site = String.fromCharCodes(base64.decode(await decrypt(entry.website, DEK)));
    user = String.fromCharCodes(base64.decode(await decrypt(entry.username, DEK)));
    pass = String.fromCharCodes(base64.decode(await decrypt(entry.password, DEK)));

    return Future.value(new Account(website: site, username: user, password: pass, isFavorite: entry.isFavorite));
  }

  @override
  Iterable<Future<Account>> decryptAll(List<Account> entries, String DEK) {
    return entries.map((e) => decryptEntry(e, DEK));
  }
}

