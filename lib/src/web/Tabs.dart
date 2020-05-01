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
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
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
        body: TabBarView(
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
    );
  }
}
