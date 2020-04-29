import 'package:alkatrazpm/src/accounts/ui/AccountsListScreen.dart';
import 'package:alkatrazpm/src/accounts/ui/EcranJmek.dart';
import 'package:alkatrazpm/src/dependencies/Dependencies.dart';
import 'package:alkatrazpm/src/password_gen/ui/PasswordGenScreen.dart';
import 'package:flutter/material.dart';

import 'src/auth/ui/AuthScreen.dart';
import 'src/web/Tabs.dart';

void main() {
  initAllDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.blue,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary
        ),
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(),
      //home: CustomTabBar(),
    );
  }
}
