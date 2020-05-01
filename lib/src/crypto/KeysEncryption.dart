abstract class KeysEncryption{
  Future<String> dataEncryptionKey();
  Future<String> keyEncryptionKey(String password);
  Future<String> passwordHash(String password, int iterations);
}