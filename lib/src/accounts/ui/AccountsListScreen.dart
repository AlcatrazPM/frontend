import 'package:alkatrazpm/src/accounts/ui/AccountDetailsScreen.dart';
import 'package:alkatrazpm/src/accounts/ui/AddAcountDialog.dart';
import 'package:alkatrazpm/src/accounts/ui/Menu.dart';
import 'package:alkatrazpm/src/auth/ui/AuthScreen.dart';
import 'package:alkatrazpm/src/password_gen/ui/PasswordGenScreen.dart';
import 'package:alkatrazpm/src/ui_utils/UIUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AccountsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: kIsWeb ? null : Menu(),
      appBar: AppBar(
        title: kIsWeb
            ? Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.security),
                    onPressed: () {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            contentPadding: EdgeInsets.all(0.0),
                            content: Container(
                                width: 400,
                                child: PasswordGenScreen()),
                          ));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "generate password",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Spacer(flex: 1),
                  Text("Alcatraz"),
                  Spacer(flex: 1),
                  Text(
                    "logout",
                    style: TextStyle(fontSize: 13),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (ctx) => AuthScreen()));
                    },
                    icon: Icon(Icons.exit_to_app),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(flex: 1),
                  Text("Alcatraz"),
                  Spacer(flex: 2)
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, child: AddAccountDialog());
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Container(
          width: UiUtils.adaptableWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              kIsWeb
                  ? Container(
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 32.0, bottom: 16),
                            child: Text("Registered Accounts:"),
                          )
                        ],
                      ),
                    )
                  : Container(),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (ctx, i) {
                    String websiteTag = "web$i";
                    String usernameTag = "user$i";
                    return Dismissible(
                      key: Key(i.toString()),
                      background: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.red[300],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.delete_forever,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Spacer(),
                                Icon(
                                  Icons.delete_forever,
                                  color: Colors.white,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showDetails(context, websiteTag);
                        },
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(kIsWeb ? 8.0 : 16.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Hero(
                                          tag: websiteTag,
                                          child: Material(
                                            type: MaterialType.transparency,
                                            child: Text(
                                              "www.example.com",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Hero(
                                            tag: usernameTag,
                                            child: Material(
                                              type: MaterialType.transparency,
                                              child: Text(
                                                "username_jmek",
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.account_box,
                                      size: 50,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FlatButton(
                                      child: Icon(Icons.keyboard_arrow_down),
                                      onPressed: (){
                                        showDetails(context, websiteTag);
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDetails(BuildContext context, String websiteTag){
    if (kIsWeb) {
      showDialog(
          context: context,
          child: AlertDialog(
            contentPadding: EdgeInsets.all(0.0),
            content: Container(
                width: 400,
                child: AccountDetailsScreen(websiteTag)),
          ));
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) =>
                AccountDetailsScreen(websiteTag)));
  }
}
