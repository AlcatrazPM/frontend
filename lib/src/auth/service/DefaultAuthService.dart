import 'package:alkatrazpm/src/auth/model/AuthCredentials.dart';
import 'package:alkatrazpm/src/auth/model/User.dart';
import 'package:alkatrazpm/src/auth/service/AuthService.dart';
import 'package:dio/dio.dart';

//TODO save session in shared prefs
class DefaultAuthService implements AuthService {
  Dio _dio;
  User _user;
  DefaultAuthService(this._dio);

  @override
  Future<User> login(AuthCredentials credentials) async {
    try {
      var response =
          await _dio.post("/login", data: credentials.toJson());
      if(response.statusCode == 200) {
        print(response.data);
        print(response.data.toString());
        AuthResponse authResponse = AuthResponse.fromJson(response.data);
        _user = User(credentials.email, authResponse);
        return Future.value(_user);
      }else return Future.error("some error");
    } catch (e) {
      if(e is DioError){
        return Future.error(e.message);
      }else
        return Future.error(e.toString());

    }
  }

  @override
  Future<User> register(AuthCredentials credentials) async{
    try {
      var response =
          await _dio.post("/register", data: credentials.toJson());
      if(response.statusCode == 201) {
        var authResponse = AuthResponse.fromJson(response.data);
        _user = User(credentials.email, authResponse);
        return Future.value(_user);
      }else return Future.error("some error");
    } catch (e) {
      if(e is DioError){
        return Future.error(e.message);
      }else
        return Future.error(e.toString());

    }
  }

  @override
  Future<User> loggedUser() async{
    return Future.value(_user);
  }
}
