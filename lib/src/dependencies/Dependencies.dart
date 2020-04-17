import 'package:alkatrazpm/src/auth/service/AuthService.dart';
import 'package:alkatrazpm/src/auth/service/DefaultAuthService.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt deps = GetIt.instance;

initAllDependencies() {

//  String apiBase = "https://5e8eebaffe7f2a00165eeb93.mockapi.io/Ar";
  String apiBase = "https://dorel.free.beeceptor.com";

  Dio dio = Dio(BaseOptions(baseUrl: apiBase));

  deps.registerSingleton<AuthService>(DefaultAuthService(dio));

  deps.registerSingleton<Dio>(dio);
}
