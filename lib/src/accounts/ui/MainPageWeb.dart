import 'package:alkatrazpm/src/auth/ui/AccountAdminWeb.dart';
import 'package:alkatrazpm/src/auth/ui/AuthScreen.dart';
import 'package:alkatrazpm/src/ui_utils/UIUtils.dart';
import 'package:alkatrazpm/src/ui_utils/UiTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPageWeb extends StatefulWidget {
  @override
  _MainPageWebState createState() => _MainPageWebState();
}

class _MainPageWebState extends State<MainPageWeb>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = TabController(vsync: this, initialIndex: 0, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: UiThemes.webThemeScreen(context),
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.blue,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Spacer(flex: 2,),
                  Icon(Icons.security, size: 30, color: Colors.white,),
                  Spacer(),
                  Expanded(
                    flex: UiUtils.tabBarFlex(context),
                    child: TabBar(
                      labelPadding: EdgeInsets.all(0.0),
                      indicatorWeight: 4.0,
                      tabs: <Widget>[
                        Tab(
                          child: Text("Vault"),
                        ),
                        Tab(
                          child: Text("Tools"),
                        ),
                        Tab(
                          child: Text("Settings"),
                        ),
                      ],
                      controller: controller,
                    ),
                  ),
                  Spacer(flex: 20),
                  Padding(
                    padding: const EdgeInsets.only(right:32.0),
                    child: DropdownButton<String>(
                      value: "  ",

                      icon: Row(
                        children: <Widget>[
                          Icon(Icons.account_circle, color: Colors.white,),
                          Icon(Icons.arrow_drop_down, color: Colors.white),
                        ],
                      ),
                      underline: Container(),
                      items:[
                        DropdownMenuItem<String>(
                          value: "  ",
                          child: Text("  "),
                        ),
                        DropdownMenuItem<String>(
                          value: "Logout",
                          child: Text("Logout"),
                        ),
                        DropdownMenuItem<String>(
                          value: "Manage",
                          child: Text("Logout"),
                        ),
                      ],
                      onChanged: (s){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
                          return AuthScreen();
                        }));
                      },
                    ),
                  ),
                  Spacer(flex: 1)
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-50,
              child: TabBarView(
                controller: controller,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width-50,
                    child: SingleChildScrollView(
                      child: AccountAdminWeb(),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width-50,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[Text("djnjkd")],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width-50,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[Text("djnjkd")],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
