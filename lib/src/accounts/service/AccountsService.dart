import 'package:alkatrazpm/src/accounts/model/Account.dart';
import 'package:alkatrazpm/src/auth/model/User.dart';

abstract class AccountsService{
  Future<List<Account>> getAccounts();
  Future<bool> modifyAccount(Account account);
  Future<bool> changeFavorite(Account account);
  Future<bool> deleteAccount(Account account);
  Future<Account> addAccount(Account account);
}