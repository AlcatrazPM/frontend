import 'package:alkatrazpm/src/api_interceptor/LogoutInterceptor.dart';
import 'package:alkatrazpm/src/auth/ui/AuthScreen.dart';
import 'package:alkatrazpm/src/ui_utils/SnackBarUtils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LogoutInterceptorDio extends InterceptorsWrapper
    implements LogoutInterceptor {

  BuildContext _context;

  @override
  Future onResponse(Response response) {
    if (response.statusCode == 401) {
      _changeScreen();
    }
    return super.onResponse(response);
  }

  @override
  void setInterceptor(BuildContext context) {
    _context = context;
  }

  @override
  void callInterceptor() {
    _changeScreen();
  }

  void _changeScreen() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_context != null) {
        Navigator.pushReplacement(_context, MaterialPageRoute(
            builder: (ctx) => AuthScreen()
        ));
        SnackBarUtils.showError(_context, "session expired");
      }
    });

  }
}