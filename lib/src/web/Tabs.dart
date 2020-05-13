import 'package:alkatrazpm/src/api_interceptor/LogoutInterceptor.dart';
import 'package:alkatrazpm/src/auth/service/AuthService.dart';
import 'package:alkatrazpm/src/auth/ui/AuthScreen.dart';
import 'package:alkatrazpm/src/dependencies/Dependencies.dart';
import 'package:alkatrazpm/src/ui_utils/AppPage.dart';
import 'package:flutter/material.dart';

import 'package:alkatrazpm/src/web/SettingsPage.dart';
import 'package:alkatrazpm/src/web/ToolsPage.dart';
import 'package:alkatrazpm/src/web/VaultPage.dart';

// tabs
class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  Color theme_color = Colors.blue;

  Widget ExitAccountButton(BuildContext context) {
    return ButtonTheme(
      child: RaisedButton(
        color: Colors.white,
        child: Text(
          'Log out',
          style: TextStyle(fontWeight: FontWeight.bold, color: theme_color),
        ),
        onPressed: () async{
          deps.get<LogoutInterceptor>().setInterceptor(null);
          await deps.get<AuthService>().logout();
          Navigator.push(context, MaterialPageRoute(
              builder: (ctx) => AuthScreen()
          ));
        },
      ),
    );
  }

  @override//
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(//
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            child: Center(
              child: Container(
                width: 1000.0,
                child: Row(
                  children: <Widget>[
                    // column with logo icon
                    Container(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.pets,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),

                    // column with tabs
                    Container(
                      width: 300,
                      child: TabBar(
                        tabs: [
                          Tab(
                            child: Text(
                              'Vault',
                              textScaleFactor: 1.2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Tools',
                              textScaleFactor: 1.2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Settings',
                              textScaleFactor: 1.2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),

                    // column with log out button
                    Container(
                      padding: EdgeInsets.only(right: 20.0,),
                      child: Column(
                        children: <Widget>[ExitAccountButton(context)],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: AppPage(
          child: Row(
            children: <Widget>[

              Expanded(
                  flex: MediaQuery.of(context).size.width < 1700 ? 0 : 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    //color: Colors.pinkAccent,
                    child: MediaQuery.of(context).size.width < 1700 ? null : FittedBox(child: Image.asset('images/lock4.jpg'), fit: BoxFit.fitHeight,),)),

              Expanded(

                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 10,
                        blurRadius: 5,
                        offset: Offset(0, 0,), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Tab(
                        child: BetterVault(),
                      ),
                      Tab(
                        child: ToolsMainPage(),
                      ),
                      Tab(
                        child: SettingsPage(),
                      ),
                    ],
                  ),
                ),
              ),

//            Expanded(
//                flex:  MediaQuery.of(context).size.width < 1700 ? 0 : 1,
//                child: Container()),

              Expanded(
                  flex: MediaQuery.of(context).size.width < 1700 ? 0 : 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.pinkAccent,
                    child: MediaQuery.of(context).size.width < 1700 ? null : FittedBox(child: Image.asset('images/lock4.jpg'), fit: BoxFit.fitHeight, alignment: Alignment.center,),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}