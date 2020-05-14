import '../accounts/model/Account.dart';

abstract class KeysEncryption {
  Future<String> generateDataEncryptionKey();
  Future<String> encrypt(String value, String key); // Returns initial value concatenated to the encrypted value
  Future<String> decrypt(String value, String key);
  Future<String> generateKEKSalt(); // This is stored in the DB, so it must be sent to the backend
  Future<String> generateKeyEncryptionKey(String password, String salt);
  Future<String> passwordHash(String password, int iterations);
  Future<Account> decryptEntry(Account entry, String DEK);
  Future<Account> encryptEntry(Account entry, String DEK);
  Future<List<Account>> decryptAll(List<Account> entries, String DEK);
}