import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:alkatrazpm/src/accounts/ui/AccountsListScreen.dart';
import 'package:alkatrazpm/src/accounts/ui/MainPageWeb.dart';
import 'package:alkatrazpm/src/auth/model/AuthCredentials.dart';
import 'package:alkatrazpm/src/auth/model/User.dart';
import 'package:alkatrazpm/src/auth/service/AuthService.dart';
import 'package:alkatrazpm/src/dependencies/Dependencies.dart';
import 'package:alkatrazpm/src/ui_utils/AppPage.dart';
import 'package:alkatrazpm/src/ui_utils/SnackBarUtils.dart';
import 'package:alkatrazpm/src/ui_utils/UIUtils.dart';
import 'package:alkatrazpm/src/ui_utils/UiTheme.dart';
import 'package:alkatrazpm/src/web/Carusel.dart';
import 'package:alkatrazpm/src/web/Tabs.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:crypto/crypto.dart';

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
    return FutureBuilder<User>(builder: (context, snapshot){

      if((snapshot.hasData && snapshot.data == null) || snapshot.hasError ||
          !snapshot.hasData) {
        return UiUtils.isMobile(context) ? mobile(context) : web(context);
      }else{
       Future.delayed(Duration(seconds: 1), (){
         if(kIsWeb){
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)
           => CustomTabBar()));
         }else{
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)
           => AccountsListScreen()));
         }
       });
        return Container();
      }
    },
      future: deps.get<AuthService>().loggedUser(doPop: false),
    );
    return UiUtils.isMobile(context) ? mobile(context) : web(context);
  }

  LinearGradient appBarGradient() => LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[Colors.blue[300], Colors.blue[400]]);

  Widget mobile(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Theme(
        isMaterialAppTheme: true,
        data: UiThemes.authTheme(context),
        child: Scaffold(
          body: AppPage(
            isPopable: false,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colors.blue[400], Colors.blue])),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.security,
                                size: 80,
                                color: Colors.white,
                              ),
                              Text(
                                "Alkatraz PM",
                                style: TextStyle(fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: UiUtils.adaptableWidth(context),
                          child: login
                              ? LoginFragment(onLogin,
                                  changeFragment: changeFragment)
                              : RegisterFragment(
                                  onRegister,
                                  changeFragment: changeFragment,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget web(BuildContext context) {
    return SafeArea(
      child: Theme(
        isMaterialAppTheme: true,
        data: UiThemes.authThemeLight(context),
        child: Scaffold(
          body: Builder(
            builder: (context) => Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[Colors.blue[400], Colors.blue])),
                    height: MediaQuery.of(context).size.height,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 150),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 32.0),
                              child: Container(
                                padding: EdgeInsets.only(left: 30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.security,
                                      size: 150,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Alkatraz PM",
                                      style: TextStyle(
                                          fontSize: 40, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 32),
                              child: Container(
                                //color: Colors.black,
                                height: 500.0,
                                child: Carusel(),

//                                child: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  mainAxisAlignment: MainAxisAlignment.start,
//                                  children: <Widget>[
//                                    Text(
//                                      "One PM to rule them all Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam in lorem nisl. Fusce vehicula tempor facilisis. Vivamus vitae libero dignissim, placerat lacus sit amet, efficitur ligula. Vestibulum mi magna, bibendum at blandit nec, pellentesque non nisi. Pellentesque tincidunt et urna condimentum volutpat.  ",
//                                      style: TextStyle(
//                                          fontSize: 18, color: Colors.white),
//                                    ),
//                                    Padding(
//                                      padding: const EdgeInsets.all(64.0),
//                                      child: Text(
//                                        "One PM to rule them all !",
//                                        style: TextStyle(
//                                            fontSize: 18, color: Colors.white),
//                                      ),
//                                    ),
//                                  ],
//                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: UiUtils.adaptableWidth(context),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 64.0),
                          child: Container(
                            width: UiUtils.adaptableWidth(context),
                            child: login
                                ? LoginFragment(onLogin,
                                    changeFragment: changeFragment)
                                : RegisterFragment(
                                    onRegister,
                                    changeFragment: changeFragment,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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

  Future<String> changeMail(String sdf, String df) async {}

  Future<void> onLogin(String email, String password) async {
    var credentials = AuthCredentials.login(email, password);
    try {
      var user = await deps.get<AuthService>().login(credentials);
      print(user.email);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
        return kIsWeb? CustomTabBar() : AccountsListScreen();
      }));
      return Future.value();
    } catch (e) {
      print(e);
      SnackBarUtils.showError(context, e.toString());
      return Future.value(e);
    }
  }

  Future<void> onRegister(
      String email, String username, String password) async {
    var credentials = AuthCredentials.register(email, username, password);
    try {
      await Future.delayed(Duration(seconds: 0), ()async{
        await deps.get<AuthService>().register(credentials);
      });

      changeFragment();
      SnackBarUtils.showConfirmation(context, "Registration succesfull");
      return Future.value();
    } catch (e) {
      SnackBarUtils.showError(context, e.toString());
      return Future.value();
    }
  }


}
