import 'package:flutter/material.dart';


import 'package:alkatrazpm/src/accounts/model/Account.dart';
import 'SettingsPage.dart';
import 'Tabs.dart';
import 'ToolsPage.dart';
import 'VaultPage.dart';

void main() {
  runApp(MyApp());
}

// SHOLD NOT BE USED. LEFT FOR REFERENCE
// PLEASE USE LIB/MAIN.DART

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
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
         // body: BetterVault()),
         // body: ToolsMainPage()),
    //  body: SettingsPage()),
      body: CustomTabBar()),
    );
  }
}