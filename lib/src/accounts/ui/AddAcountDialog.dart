
import 'package:alkatrazpm/src/accounts/model/Account.dart';
import 'package:alkatrazpm/src/accounts/service/favicon/FavIconService.dart';
import 'package:alkatrazpm/src/dependencies/Dependencies.dart';
import 'package:alkatrazpm/src/ui_utils/AppPage.dart';
import 'package:flutter/material.dart';

class AddAccountDialog extends StatefulWidget {
  @override
  _AddAccountDialogState createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends State<AddAccountDialog> {
  TextEditingController password;
  TextEditingController website;
  TextEditingController username;

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
            future: deps.get<FavIconService>().getFavIconUrl(website.text),
            builder: (ctx, snapshot) {
              if (snapshot.hasError || !snapshot.hasData) {
                return Icon(
                  Icons.account_box,
                  size: 50,
                  color: Colors.grey,
                );
              }
              return ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 40, maxHeight: 40),
                  child: Image.network(snapshot.data));
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
                TextField(
                  controller: website,
                  onChanged: (v) {
                    if (triggerIconSearch(v)) setState(() {});
                  },
                  decoration: InputDecoration(labelText: "website"),
                ),
                TextField(
                  controller: username,
                  decoration: InputDecoration(labelText: "username"),
                ),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                      labelText: "password",
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.settings_backup_restore,
                            color: Colors.blue,
                          ))),
                ),
                Spacer(),
                Row(
                  children: <Widget>[
                    Spacer(),
                    RaisedButton(
                      child: Text("Done"),
                      onPressed: returnAccount,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void returnAccount(){
    var account = Account(username: username.text, password: password.text,
        website: website.text);
    Navigator.pop(context, account);
  }

  bool triggerIconSearch(String text) {
    RegExp exp = RegExp(r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:'
        r'\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0'
        r'-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)');
    return exp.hasMatch(text);
  }
}
