import 'dart:io';
import 'package:alkatrazpm/src/accounts/service/AccountsService.dart';
import 'package:alkatrazpm/src/accounts/service/DefaultAccountsService.dart';
import 'package:alkatrazpm/src/accounts/service/favicon/DefaultFavIconService.dart';
import 'package:alkatrazpm/src/accounts/service/favicon/FavIconService.dart';
import 'package:alkatrazpm/src/api_interceptor/LogoutInterceptor.dart';
import 'package:alkatrazpm/src/api_interceptor/LogoutInterceptorDio.dart';
import 'package:alkatrazpm/src/auth/service/AuthService.dart';
import 'package:alkatrazpm/src/auth/service/DefaultAuthService.dart';
import 'package:alkatrazpm/src/crypto/KeysEncryption.dart';
import 'package:alkatrazpm/src/crypto/KeysEncryptionDefault.dart';
import 'package:alkatrazpm/src/file_saver/FileSaver.dart';
import 'package:alkatrazpm/src/crypto/KeysEncryption.dart'
    if (dart.library.io) 'package:alkatrazpm/src/file_saver/FileSaverDefault.dart'
    if (dart.library.html) 'package:alkatrazpm/src/web/FileSaver.dart';
import 'package:alkatrazpm/src/password_gen/service/PasswordGen.dart';
import 'package:alkatrazpm/src/password_gen/service/PasswordGenDefault.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

GetIt deps = GetIt.instance;

initAllDependencies() {
  var address = DotEnv.env['ADDR'];
  var interceptor = LogoutInterceptorDio();

  Dio authDio = Dio(BaseOptions(baseUrl: "http://$address/apii/auth"));
  authDio.interceptors.add(interceptor);

  Dio dataDio = Dio(BaseOptions(baseUrl: "http://$address/apii/accounts"));

  dataDio.interceptors.add(interceptor);

  deps.registerSingleton<Dio>(dataDio);
  deps.registerSingleton<LogoutInterceptor>(interceptor);
  deps.registerSingleton<AuthService>(DefaultAuthService(authDio));
  deps.registerSingleton<AccountsService>(DefaultAccountsService(dataDio));
  deps.registerSingleton<KeysEncryption>(KeysEncryptionDefault());
  deps.registerSingleton<FavIconService>(DefaultFavIconService());
  deps.registerSingleton<PasswordGen>(PasswordGenDefault());

  deps.registerSingleton<FileSaver>(FileSaverDefault());
}
