
import 'dart:convert';
import 'dart:typed_data';

import 'package:alkatrazpm/src/accounts/model/Account.dart';
import 'package:alkatrazpm/src/accounts/model/AccountsFilter.dart';
import 'package:alkatrazpm/src/accounts/service/AccountsService.dart';
import 'package:alkatrazpm/src/accounts/service/favicon/FavIconService.dart';
import 'package:alkatrazpm/src/api_interceptor/LogoutInterceptor.dart';
import 'package:alkatrazpm/src/auth/model/User.dart';
import 'package:alkatrazpm/src/auth/service/AuthService.dart';
import 'package:alkatrazpm/src/crypto/KeysEncryption.dart';
import 'package:alkatrazpm/src/dependencies/Dependencies.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO update when backend is ready
class DefaultAccountsService implements AccountsService {
  Dio _dio;
  DefaultAccountsService(this._dio);


  @override
  Future<List<Account>> getAccounts() async {
    try {
      var user = await deps.get<AuthService>().loggedUser();
      var response =
          await _dio.get("/accounts",
              options: Options(headers: {
                "Authorization" : "Bearer ${user.authResponse.jwt}"
              }));
      if (response.statusCode == 200) {
        var accounts = (response.data["accounts"] as List<dynamic>)
            .map((e) => Account.fromJson(e)).toList();

        var sharedPrefs = await SharedPreferences.getInstance();



        accounts = await deps.get<KeysEncryption>().decryptAll(accounts,
          sharedPrefs.get("DEK"));
        var favIconService = deps.get<FavIconService>();
        for(Account account in accounts){
          account.iconBytes =
          await favIconService.getFavIcon(account.website);
          print(account.iconBytes.length);

        }
        return Future.value(accounts);
      }
      return Future.error("Scary error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<bool> changeFavorite(Account account) async{
    account.isFavorite = !account.isFavorite;
    return modifyAccount(account);
  }

  @override
  Future<bool> modifyAccount(Account account) async{
    try {
      var sharedPrefs = await SharedPreferences.getInstance();
      var user = await deps.get<AuthService>().loggedUser();
      var encrypted = await deps.get<KeysEncryption>().encryptEntry(account,
        sharedPrefs.get("DEK"));
      var response =
      await _dio.put("/modifyaccount",
          options: Options(headers: {
            "Authorization" : "Bearer ${user.authResponse.jwt}"
          }),
          data: encrypted.toJson());
      if (response.statusCode == 200) {
        return Future.value(true);
      }
      return Future.error("Scary error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<bool> deleteAccount(Account account) async{
    try {
      var user = await deps.get<AuthService>().loggedUser();
      var response =
          await _dio.delete("/modifyaccount",
          options: Options(headers: {
            "Authorization" : "Bearer ${user.authResponse.jwt}"
          }),
          data: {
            "id": account.id
          });
      if (response.statusCode == 200) {
        return Future.value(true);
      }
      return Future.error("Scary error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<Account> addAccount(Account account) async{
    int s = DateTime.now().millisecondsSinceEpoch;
    account.id = s.toString();
    try {
      var sharedPrefs = await SharedPreferences.getInstance();
      var user = await deps.get<AuthService>().loggedUser();
      var encrypted = await deps.get<KeysEncryption>().encryptEntry(account,
          sharedPrefs.get("DEK"));

      var response =
          await _dio.put("/addaccount",
          options: Options(headers: {
            "Authorization" : "Bearer ${user.authResponse.jwt}"
          }),
          data: encrypted.toJson()..remove("id"));
      if (response.statusCode == 201) {
        account.id = response.data["id"];
        return Future.value(account);
      }
      return Future.error("Scary error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  List<Account> filter(List<Account> list, AccountsFilter filter) {
   var res =  list.map((e) => e).toList()..removeWhere((element){
     if(filter.toSearch != "" && !element.website.contains(filter.toSearch))
       return true;
     if(filter.onlyFavorites && !element.isFavorite)
         return true;
     return false;
   });
   print(res.length);
   return res;
  }
}
