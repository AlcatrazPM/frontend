import 'package:alkatrazpm/src/password_gen/PasswordGen.dart';
import 'package:alkatrazpm/src/password_gen/model/PasswordAttributes.dart';
import 'package:alkatrazpm/src/ui_utils/AppPage.dart';
import 'package:alkatrazpm/src/ui_utils/SnackBarUtils.dart';
import 'package:alkatrazpm/src/ui_utils/UIUtils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordGenScreen extends StatefulWidget {
  @override
  _PasswordGenScreenState createState() => _PasswordGenScreenState();
}

class _PasswordGenScreenState extends State<PasswordGenScreen> {
  TextEditingController generatedPassword;
  double length = 12;
  bool az = true;
  bool AZ = true;
  bool digits = true;
  bool special = false;

  @override
  void initState() {
    generatedPassword = TextEditingController(text: "sdlnjvjkMD3234kjvjk");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !kIsWeb,
        title: kIsWeb
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                  Spacer(flex: 1),
                  Text("Password gen"),
                  Spacer(flex: 2)
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(flex: 1),
                  Text("Password gen"),
                  Spacer(flex: 2)
                ],
              ),
      ),
      body: AppPage(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: UiUtils.adaptableWidth(context),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      textAlign: TextAlign.center,
                      controller: generatedPassword,
                      enabled: false,
                      decoration: InputDecoration(
                          filled: true, fillColor: Colors.grey[300]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              onPressed: onGeneratePassword,
                              child: Text("Regenerate"),
                            ),
                          ),
                          Expanded(
                            child: FlatButton(
                              onPressed: copyPassword,
                              child: Text("Copy"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "length ${length.toInt()}  ",
                          ),
                          Expanded(
                            child: Slider(
                              value: length,
                              min: 8,
                              max: 50,
                              divisions: 100,
                              label: "${length.toInt()}",
                              onChanged: (newVal) {
                                length = newVal;
                                onGeneratePassword();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                "a-z",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Switch(
                                  value: az,
                                  onChanged: (val) {
                                    az = val;
                                    onGeneratePassword();
                                  }),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                "0-9",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Spacer(),
                              Switch(
                                  value: digits,
                                  onChanged: (val) {
                                    digits = val;
                                    onGeneratePassword();
                                  })
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Text(
                                "a-Z",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Switch(
                                  value: AZ,
                                  onChanged: (val) {
                                    AZ = val;
                                    onGeneratePassword();
                                  }),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "#!)(}/*&^%{",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Spacer(),
                              Switch(
                                  value: special,
                                  onChanged: (val) {
                                    special = val;
                                    onGeneratePassword();
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "minimum digits"),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "minimum special"),
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: "excluded characters"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void copyPassword() {
    Clipboard.setData(ClipboardData(text: generatedPassword.text));
    SnackBarUtils.showConfirmation(context, "password copied to clipboard");
  }

  void onGeneratePassword() {
    var attributes = PasswordAttributes(
      hasLowerCase: az,
      hasUpperCase: AZ,
      hasNumbers: digits,
      hasSpecialChars: special,
      length: length.toInt(),
    );
    genPassword(attributes);
  }

  void genPassword(PasswordAttributes attributes) {
    try {
      var password = PasswordGenerator.generatePassword(attributes);
      generatedPassword.text = password;
      setState(() {});
    } catch (e) {
      SnackBarUtils.showError(context, e.toString());
    }
  }
}
