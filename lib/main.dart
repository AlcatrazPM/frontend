import 'package:alkatrazpm/src/accounts/ui/AccountsListScreen.dart';
import 'package:alkatrazpm/src/accounts/ui/EcranJmek.dart';
import 'package:alkatrazpm/src/api_interceptor/LogoutInterceptor.dart';
import 'package:alkatrazpm/src/dependencies/Dependencies.dart';
import 'package:alkatrazpm/src/password_gen/ui/PasswordGenScreen.dart';
import 'package:alkatrazpm/src/web/Carusel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'src/auth/ui/AuthScreen.dart';
import 'src/web/Tabs.dart';

void main() async{
  await DotEnv.load(fileName: "dotenv");

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
      //home: Carusel(),
    );
  }
}
