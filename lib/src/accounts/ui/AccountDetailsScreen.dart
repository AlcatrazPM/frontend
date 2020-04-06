import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AccountDetailsScreen extends StatefulWidget {
  final String _websiteTag;

  AccountDetailsScreen(this._websiteTag);

  @override
  _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  TextEditingController username;
  TextEditingController password;
  bool edit = false;

  @override
  void initState() {
    username = TextEditingController(text: "username_jmek");
    password = TextEditingController(text: "password");
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
              onPressed: () {
                edit = !edit;
                setState(() {});
              },
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: widget._websiteTag,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      "www.example.com",
                      style: TextStyle(fontSize: 25, color: Colors.grey),
                    ),
                  ),
                ),
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
                          decoration: InputDecoration(
                            labelText: "password:",
                            suffixIcon: IconButton(
                              onPressed: (){
                                password.text = "dfgdfgdfgdfg";
                                setState(() {});
                              },
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
                                password.text,
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
}
