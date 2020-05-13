import 'package:alkatrazpm/src/accounts/model/Account.dart';
import 'package:alkatrazpm/src/accounts/service/AccountsService.dart';
import 'package:alkatrazpm/src/accounts/service/favicon/FavIconService.dart';
import 'package:alkatrazpm/src/auth/service/AuthService.dart';
import 'package:alkatrazpm/src/dependencies/Dependencies.dart';
import 'package:alkatrazpm/src/password_gen/service/PasswordGen.dart';
import 'package:alkatrazpm/src/ui_utils/SnackBarUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AccountDetailsScreen extends StatefulWidget {
  final Account _account;

  AccountDetailsScreen(this._account);

  @override
  _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  TextEditingController username;
  TextEditingController password;
  bool edit = false;

  @override
  void initState() {
    username = TextEditingController(text: widget._account.username);
    password = TextEditingController(text: widget._account.password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !kIsWeb,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            !kIsWeb? Container() :
            IconButton(
              onPressed: (){
                Navigator.of(context, rootNavigator: true).pop();
              },
              icon: Icon(Icons.close),
            ),
            Spacer(flex: 1),
            Text("Account"),
            Spacer(flex: 1),
            IconButton(
              onPressed: editPressed,
              icon: Icon(edit ? Icons.check : Icons.edit),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("website: "),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: "",
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          widget._account.website,
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  ConstrainedBox(
                      constraints:
                      BoxConstraints(maxWidth: 60, maxHeight: 60),
                      child: Image.memory(widget._account.iconBytes, scale: 0.6,))
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Material(
                  type: MaterialType.transparency,
                  child: edit
                      ? TextFormField(
                          controller: username,
                          decoration: InputDecoration(labelText: "username:"),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "username:",
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                username.text,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  child: edit
                      ? TextFormField(
                          controller: password,
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            labelText: "password:",
                            suffixIcon: IconButton(
                              onPressed: genPassword,
                              icon: Icon(Icons.refresh),
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("password:"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "*"*password.text.length,

                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
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
    );
  }

  Future<void> genPassword()async{
    password.text = await deps.get<PasswordGen>().generatePassword();
  }

  void editPressed(){
    if(edit){
      widget._account.password = password.text;
      widget._account.username = username.text;
      modifyAccount(widget._account);
    }
    edit = !edit;
    setState(() {});
  }
  Future<void> modifyAccount(Account account) async{
    try {
      await deps.get<AccountsService>().modifyAccount(account);
      SnackBarUtils.showConfirmation(context, "account modified");
    }catch(e){
      SnackBarUtils.showError(context, e);
    }
  }


}
