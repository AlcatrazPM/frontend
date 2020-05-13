import 'dart:typed_data';

import 'package:alkatrazpm/src/accounts/model/Account.dart';
import 'package:alkatrazpm/src/accounts/service/favicon/FavIconService.dart';
import 'package:alkatrazpm/src/dependencies/Dependencies.dart';
import 'package:alkatrazpm/src/password_gen/service/PasswordGen.dart';
import 'package:alkatrazpm/src/ui_utils/AppPage.dart';
import 'package:alkatrazpm/src/utils/Validators.dart';
import 'package:flutter/material.dart';

class AddAccountDialog extends StatefulWidget {
  @override
  _AddAccountDialogState createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends State<AddAccountDialog> {
  TextEditingController password;
  TextEditingController website;
  TextEditingController username;

  var _passwordKey = GlobalKey<FormState>();
  var _websiteKey = GlobalKey<FormState>();
  var _usernameKey = GlobalKey<FormState>();

  Uint8List _icon;

  @override
  void initState() {
    password = TextEditingController(text: "sdfnjgjk gfkj ");
    username = TextEditingController();
    website = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: <Widget>[
          Text("Add account"),
          Spacer(),
          FutureBuilder(
            future: deps.get<FavIconService>().getFavIcon(website.text),
            builder: (ctx, snapshot) {
              if (snapshot.hasError || !snapshot.hasData) {
                return Container();
              }
              _icon = snapshot.data;
              return ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 40, maxHeight: 40),
                  child: Image.memory(
                    _icon,
                    scale: 0.6,
                  ));
            },
          ),
        ],
      ),
      content: AppPage(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              children: <Widget>[
                Form(
                  key: _websiteKey,
                  child: TextFormField(
                    validator: Validators.websiteValidator,
                    controller: website,
                    onChanged: (v) {
                      _websiteKey.currentState.validate();
                      if (triggerIconSearch(v)) {
                        setState(() {});
                      }
                    },
                    decoration: InputDecoration(labelText: "website"),
                  ),
                ),
                Form(
                  key: _usernameKey,
                  child: TextFormField(
                    validator: Validators.usernameValidator,
                    onChanged: (v) {
                      _usernameKey.currentState.validate();
                    },
                    controller: username,
                    decoration: InputDecoration(labelText: "username"),
                  ),
                ),
                Form(
                  key: _passwordKey,
                  child: TextFormField(
                    validator: Validators.passwordValidator,
                    onChanged: (v) {
                      _passwordKey.currentState.validate();
                    },
                    controller: password,
                    decoration: InputDecoration(
                        labelText: "password",
                        suffixIcon: IconButton(
                            onPressed: genPassword,
                            icon: Icon(
                              Icons.settings_backup_restore,
                              color: Colors.blue,
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Spacer(),
                      RaisedButton(
                        child: Text("Done"),
                        onPressed: returnAccount,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> genPassword() async {
    password.text = await deps.get<PasswordGen>().generatePassword();
  }

  void returnAccount() async {
    if (validate()) {
      if (_icon.length < 100)
        _icon = await deps.get<FavIconService>().getFavIcon(website.text);
      var account = Account(
          username: username.text,
          password: password.text,
          website: website.text,
          iconBytes: _icon);
      Navigator.pop(context, account);
    }
  }

  bool validate() {
    var password = _passwordKey.currentState.validate();
    var username = _usernameKey.currentState.validate();
    var website = _websiteKey.currentState.validate();
    return password && username && website;
  }

  bool triggerIconSearch(String text) {
    RegExp exp = RegExp(r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:'
        r'\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0'
        r'-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)');
    return exp.hasMatch(text);
  }
}
