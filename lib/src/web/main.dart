import 'package:flutter/material.dart';


import 'Account.dart';
import 'SettingsPage.dart';
import 'ToolsPage.dart';
import 'VaultPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Account _account;

  @override
  void initState() {

    _account = new Account('', '', '', true);

  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlcatrazPM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      //home: TextWidget(),
      //home: LogInPage(),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
          body: BetterVault()),
    );
  }
}