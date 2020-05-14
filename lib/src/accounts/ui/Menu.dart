import 'package:alkatrazpm/src/api_interceptor/LogoutInterceptor.dart';
import 'package:alkatrazpm/src/auth/service/AuthService.dart';
import 'package:alkatrazpm/src/auth/ui/AuthScreen.dart';
import 'package:alkatrazpm/src/dependencies/Dependencies.dart';
import 'package:alkatrazpm/src/password_gen/ui/PasswordGenScreen.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.7,
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: DrawerHeader(
                child: Icon(Icons.account_circle, size: 70,))),
            FlatButton(onPressed: () {
              Scaffold.of(context).openEndDrawer();
              Navigator.push(context, MaterialPageRoute(
                  builder: (ctx) => PasswordGenScreen()
              ));
            }, child: Text("Generate password")),
            FlatButton(onPressed: () {}, child: Text("Change password")),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(onPressed: () async {
                await deps.get<AuthService>().logout();
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (ctx) => AuthScreen()
                ));
              }, child: Row(
                children: <Widget>[
                  Text("logout"),
                  Spacer(),
                  Icon(Icons.exit_to_app)
                ],
              ),),
            ),

          ],
        ),
      ),
    );
  }
}
