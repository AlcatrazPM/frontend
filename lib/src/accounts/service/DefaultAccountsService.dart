
import 'package:alkatrazpm/src/accounts/model/Account.dart';
import 'package:alkatrazpm/src/accounts/service/AccountsService.dart';
import 'package:alkatrazpm/src/auth/model/User.dart';
import 'package:alkatrazpm/src/auth/service/AuthService.dart';
import 'package:alkatrazpm/src/dependencies/Dependencies.dart';
import 'package:dio/dio.dart';

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
        return Future.value(accounts);
      }
      return Future.error("Scary error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<bool> changeFavorite(Account account) async{
    try {
      var user = await deps.get<AuthService>().loggedUser();
      var response =
          await _dio.post("/modifyaccount",
          options: Options(headers: {
            "Authorization" : "Bearer ${user.authResponse.jwt}"
          }),
          data: account.toJson());
      if (response.statusCode == 201) {
        return Future.value(true);
      }
      return Future.error("Scary error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<bool> modifyAccount(Account account) async{
    try {
      var user = await deps.get<AuthService>().loggedUser();
      var response =
      await _dio.put("/modifyaccount",
          options: Options(headers: {
            "Authorization" : "Bearer ${user.authResponse.jwt}"
          }),
          data: account.toJson());
      if (response.statusCode == 201) {
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
          await _dio.put("/modifyaccount",
          options: Options(headers: {
            "Authorization" : "Bearer ${user.authResponse.jwt}"
          }),
          data: account.toJson());
      if (response.statusCode == 201) {
        return Future.value(true);
      }
      return Future.error("Scary error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<Account> addAccount(Account account) async{
    account.id = "${DateTime.now().millisecondsSinceEpoch}";
    try {
      var user = await deps.get<AuthService>().loggedUser();
      var response =
          await _dio.put("/modifyaccount",
          options: Options(headers: {
            "Authorization" : "Bearer ${user.authResponse.jwt}"
          }),
          data: account.toJson());
      if (response.statusCode == 201) {
        return Future.value(account);
      }
      return Future.error("Scary error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
