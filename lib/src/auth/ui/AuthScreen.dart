import 'dart:io';
import 'dart:math';

import 'package:alkatrazpm/src/accounts/ui/AccountsListScreen.dart';
import 'package:alkatrazpm/src/ui_utils/UIUtils.dart';
import 'package:flutter/foundation.dart';

import 'LoginFragment.dart';
import 'RegisterFragment.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool login = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: kIsWeb
            ? Center(
                child: Text(login ? "Login" : "Register"),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(flex: 1),
                  Text(login ? "Login" : "Register"),
                  Spacer(flex: 2)
                ],
              ),
        leading: login
            ? Container()
            : IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  changeFragment();
                }),
      ),
      body: Center(
        child: Container(
          width: UiUtils.adaptableWidth(context),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                child: login
                    ? LoginFragment(
                        onLogin,
                        changeFragment: changeFragment,
                      )
                    : RegisterFragment(
                        onRegister,
                        changeFragment: changeFragment,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void changeFragment() {
    login = !login;
    setState(() {});
  }

  Future<String> onLogin(String username, String password) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
      return AccountsListScreen();
    }));
  }

  Future<String> onRegister(String email, String username, String password) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
      return AccountsListScreen();
    }));
  }
}
