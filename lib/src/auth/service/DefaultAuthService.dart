import 'package:alkatrazpm/src/api_interceptor/LogoutInterceptor.dart';
import 'package:alkatrazpm/src/auth/model/AuthCredentials.dart';
import 'package:alkatrazpm/src/auth/model/User.dart';
import 'package:alkatrazpm/src/auth/service/AuthService.dart';
import 'package:alkatrazpm/src/crypto/KeysEncryption.dart';
import 'package:alkatrazpm/src/dependencies/Dependencies.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO save session in shared prefs
class DefaultAuthService implements AuthService {
  static const String _LOGGED_IN = "loggedIn";
  static const String _USERNAME = "username";
  static const String _EMAIL = "email";
  static const String _I_KEK = "i_kek";
  static const String _E_DEK = "e_dek";
  static const String _SESSION_TIMER = "session_timer";
  static const String _SESSION_START_DATE = "session_start_date";
  static const String _JWT = "JWT";
  static const String _DEK = "DEK";

  Dio _dio;
  User _user;

  DefaultAuthService(this._dio);

  @override
  Future<User> login(AuthCredentials credentials) async {
    try {
      var encrypt = deps.get<KeysEncryption>();

      var hashedPassword = await encrypt
          .passwordHash(credentials.password, 100);
      print("hashed:\n"+hashedPassword);
      var response = await _dio.post("/login", data: {
        "username": credentials.email,
        "password": hashedPassword,
      });
      if (response.statusCode == 201 || response.statusCode == 200) {
        AuthResponse authResponse = AuthResponse.fromJson(response.data);
        authResponse.sessionTimer = Duration(minutes: authResponse.sessionTimer)
            .inMilliseconds;
        authResponse.sessionStartDate = DateTime
            .now()
            .millisecondsSinceEpoch;
        _user = User(credentials.email, authResponse);
        await saveUser(_user);

        print(authResponse.iKek);
        print(authResponse.eDek);


        var sharedPrefs = await SharedPreferences.getInstance();
        sharedPrefs.setString(
          _DEK, 
          await encrypt.decrypt(
            authResponse.eDek, 
            await encrypt.generateKeyEncryptionKey(
              credentials.password,
              authResponse.iKek), 
            "true"));

        print(sharedPrefs.getString(_DEK));

        return Future.value(_user);
      }
      return Future.error("some error");
    } catch (e) {
      if (e is DioError) {
        if (e.response.statusCode == 499)
          return Future.error("Unregistered User");
        return Future.error(e.message);
      }
      return Future.error(e.toString());
    }
  }


  @override
  Future<void> register(AuthCredentials credentials) async {
    try {

      var encrypt = deps.get<KeysEncryption>();
      var iKEK = await encrypt.generateKEKSalt();
      print(iKEK);
        // encrypt.generateKeyEncryptionKey(
        //     credentials.password, await encrypt.generateKEKSalt());

      var eDEK = await encrypt.encrypt(
        await encrypt.generateDataEncryptionKey(), 
        await encrypt.generateKeyEncryptionKey(
          credentials.password, 
          iKEK),
          "true");
      print(eDEK);
      
      var hashedPassword =
        await encrypt.passwordHash(credentials.password, 100);

      var response = await _dio.post("/register", data: {
        "username": credentials.email,
        "name": credentials.username,
        "password": hashedPassword,
        "i_kek": iKEK,
        "e_dek": eDEK,
      });
      if (response.statusCode == 201) {
        return Future.value();
      }
      return Future.error("some error");
    } catch (e) {
      if (e is DioError) {
        if (e.response.statusCode == 498) {
          return Future.error("User already registered");
        }
        return Future.error(e.message);
      }
      return Future.error(e.toString());
    }
  }

  @override
  Future<User> loggedUser({bool doPop = true}) async {
    if (_user != null) {
      if (_isValidSession()) {
        return Future.value(_user);
      }
      deps.get<LogoutInterceptor>().callInterceptor();
      return Future.value(null);
    }
    var sharedPrefs = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPrefs.getBool(_LOGGED_IN);
    if (isLoggedIn) {
      var authResponse = AuthResponse();
      authResponse.sessionTimer = sharedPrefs.getInt(_SESSION_TIMER);
      authResponse.eDek = sharedPrefs.getString(_E_DEK);
      authResponse.iKek = sharedPrefs.getString(_I_KEK);
      authResponse.jwt = sharedPrefs.getString(_JWT);
      authResponse.sessionStartDate = sharedPrefs.getInt(_SESSION_START_DATE);
      _user = User(sharedPrefs.getString(_EMAIL), authResponse);
      if (_isValidSession()) {
        return Future.value(_user);
      }
      return Future.value(null);
    }
    deps.get<LogoutInterceptor>().callInterceptor();
    return Future.value(null);
  }

  Future<void> saveUser(User user) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    // var encrypt = deps.get<KeysEncryption>();

    sharedPrefs.setBool(_LOGGED_IN, true);
    sharedPrefs.setString(_EMAIL, user.email);
    sharedPrefs.setString(_JWT, user.authResponse.jwt);
    sharedPrefs.setString(_E_DEK, user.authResponse.eDek);
    sharedPrefs.setString(_I_KEK, user.authResponse.iKek);
    sharedPrefs.setInt(_SESSION_TIMER, user.authResponse.sessionTimer);
    sharedPrefs.setInt(
        _SESSION_START_DATE, DateTime
        .now()
        .millisecondsSinceEpoch);

    return Future.value();
  }

  @override
  Future<void> logout() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setBool(_LOGGED_IN, false);
    _user = null;
  }

  @override
  Future<void> modifyMasterPassword(String oldPassword,
      String newPassword) async {
    try {
      var encrypt = deps.get<KeysEncryption>();
      var oldPasswordHashed = await encrypt.passwordHash(oldPassword, 100);
      var newPasswordHashed = await encrypt.passwordHash(oldPassword, 100);
      var response = await _dio.post("/modifyPassword",
          data: {
            "username": _user.email,
            "old_password": oldPasswordHashed,
            "new_password": newPasswordHashed
          },
          options: Options(
              headers: {"Authorization": "Bearer ${_user.authResponse.jwt}"}));
      if (response.statusCode == 200) {
        return Future.value();
      }
      return Future.error("some error");
    } catch (e) {
      if (e is DioError) {
        return Future.error(e.message);
      }
      return Future.error(e.toString());
    }
  }

  @override
  Future<void> modifyEmail(String newEmail) async {
    try {
      var response = await _dio.post("/modifyacctdata",
          data: {
            "field_name": "email",
            "new_value": newEmail,
          },
          options: Options(
              headers: {"Authorization": "Bearer ${_user.authResponse.jwt}"}));
      if (response.statusCode == 200) {
        return Future.value();
      }
      return Future.error("some error");
    } catch (e) {
      if (e is DioError) {
        return Future.error(e.message);
      }
      return Future.error(e.toString());
    }
  }

  @override
  Future<void> modifySessionTimer(int newTimer) async {
    try {
      var response = await _dio.post("/modifyacctdata",
          data: {
            "field_name": "session_timer",
            "new_value": newTimer,
          },
          options: Options(
              headers: {"Authorization": "Bearer ${_user.authResponse.jwt}"}));
      if (response.statusCode == 200) {
        return Future.value();
      }
      return Future.error("some error");
    } catch (e) {
      if (e is DioError) {
        return Future.error(e.message);
      }
      return Future.error(e.toString());
    }
  }

  @override
  Future<void> modifyUsername(String newUsername) async {
    try {
      var response = await _dio.post("/modifyacctdata",
          data: {
            "field_name": "name",
            "new_value": newUsername,
          },
          options: Options(
              headers: {"Authorization": "Bearer ${_user.authResponse.jwt}"}));
      if (response.statusCode == 200) {
        return Future.value();
      }
      return Future.error("some error");
    } catch (e) {
      if (e is DioError) {
        return Future.error(e.message);
      }
      return Future.error(e.toString());
    }
  }

  bool _isValidSession() {
    int timePassed = DateTime
        .now()
        .millisecondsSinceEpoch -
        _user.authResponse.sessionStartDate;
    if (timePassed < _user.authResponse.sessionTimer) {
      return true;
    }
    deps.get<LogoutInterceptor>().callInterceptor();
    return false;
  }
}
