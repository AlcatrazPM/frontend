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
            child: Row(
              children: <Widget>[
                // column with logo icon
                Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.pets,
                          color: Colors.white,
                        )
                      ],
                    )),

                // column with tabs
                Expanded(
                  flex: 3,
                  child: TabBar(
                    tabs: [
                      Text(
                        'Vault',
                        textScaleFactor: 1.2,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Tools',
                        textScaleFactor: 1.2,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Settings',
                        textScaleFactor: 1.2,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                // column with log out button
                Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[ExitAccountButton(context)],
                    )),
              ],
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
