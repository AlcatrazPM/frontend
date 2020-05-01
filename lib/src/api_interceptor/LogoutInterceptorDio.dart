import 'package:alkatrazpm/src/api_interceptor/LogoutInterceptor.dart';
import 'package:alkatrazpm/src/auth/ui/AuthScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoutInterceptorDio extends InterceptorsWrapper
    implements LogoutInterceptor {

  BuildContext _context;

  @override
  Future onResponse(Response response) {
    if (response.statusCode == 401) {
      if (_context != null) {
        Navigator.pushReplacement(_context, MaterialPageRoute(
            builder: (ctx) => AuthScreen()
        ));
      }
    }
    return super.onResponse(response);
  }

  @override
  void setInterceptor(BuildContext context) {
    _context = context;
  }
}