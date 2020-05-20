import 'package:alkatrazpm/src/accounts/model/Account.dart';
import 'package:alkatrazpm/src/accounts/model/AccountsFilter.dart';
import 'package:alkatrazpm/src/auth/model/User.dart';

abstract class AccountsService{
  Future<List<Account>> getAccounts({bool fromCache = false});
  Future<bool> modifyAccount(Account account);
  Future<bool> changeFavorite(Account account);
  Future<bool> deleteAccount(Account account);
  Future<Account> addAccount(Account account);
  List<Account> filter(List<Account> list, AccountsFilter filter);
}