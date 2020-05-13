import 'package:alkatrazpm/src/api_interceptor/LogoutInterceptor.dart';
import 'package:alkatrazpm/src/auth/ui/AuthScreen.dart';
import 'package:alkatrazpm/src/dependencies/Dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  final Widget child;
  final bool isPopable;

  AppPage({@required this.child, this.isPopable = true});

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.isPopable)
      deps.get<LogoutInterceptor>().setInterceptor(context);
    else
      deps.get<LogoutInterceptor>().setInterceptor(null);
    return widget.child;
  }

  @override
  void dispose() {
    deps.get<LogoutInterceptor>().setInterceptor(null);
    super.dispose();
  }
}
