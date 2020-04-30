import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:alkatrazpm/src/password_gen/PasswordGen.dart';
import 'package:alkatrazpm/src/password_gen/model/PasswordAttributes.dart';

class PasswordGeneratorWidget extends StatefulWidget {
  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGeneratorWidget> {
  // date importante
  String generatedPassword = "";
  PasswordAttributes passwordAttributes;

  @override
  void initState() {
    passwordAttributes = PasswordAttributes();

    tryRegeneratePassword(passwordAttributes).then((val) => setState(() {
          generatedPassword = val;
        }));

    super.initState();
  }

  // culori folosite
  Color my_grey = Colors.grey[300];
  Color light_blue = Colors.lightBlueAccent[100];
  Color theme_color = Colors.blue;
  Color white = Colors.white;

  // constante
  final double maxWidth = 600;
  double topTitlePadding = 10.0;

  int _parseField(String text, int defaultValue) {
    int value = defaultValue;

    try {
      value = int.parse(text);
    } catch (e) {
      // Nothing
    }

    return value;
  }

  // data field = curtom text form field
  Widget DataField(String title) {
    return TextFormField(
      //autofocus: true,
      cursorColor: Colors.amber,
      style: TextStyle(height: 1.0),
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(borderSide: BorderSide(color: theme_color)),
      ),
      onChanged: (String input_user) {
        input_user.trim();
        setState(() {
          switch (title) {
            case 'Minimum numbers':
              passwordAttributes.minNumbers = _parseField(input_user, 0);
              break;
            case 'Minimum special':
              passwordAttributes.minSpecial = _parseField(input_user, 0);
              break;
            case 'Length':
              passwordAttributes.length = _parseField(input_user, 12);
          }

          tryRegeneratePassword(passwordAttributes).then((val) => setState(() {
                generatedPassword = val;
              }));
        });
      },
    );
  }

  Widget getTitle(String tit) {
    return Text(
      tit,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.8,
      ),
    );
  }

  // widget pentru o optiune speciala de generare a prolei
  Widget Option(String title, bool boolVal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title),
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: boolVal,
            activeColor: theme_color,
            onChanged: (bool value) {
              setState(() {
                switch (title) {
                  case 'A-Z':
                    passwordAttributes.hasUpperCase = value;
                    break;
                  case 'a-z':
                    passwordAttributes.hasLowerCase = value;
                    break;
                  case '0-9':
                    passwordAttributes.hasNumbers = value;
                    break;
                  case '!@#\$%^&*':
                    passwordAttributes.hasSpecialChars = value;
                    break;
                }

                tryRegeneratePassword(passwordAttributes)
                    .then((val) => setState(() {
                          generatedPassword = val;
                        }));
              });
            },
          ),
        ),
      ],
    );
  }

  // cele  4 optiuni speciale de generare a parolei
  Widget Options() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Option('A-Z', passwordAttributes.hasUpperCase),
            ),
            Expanded(
              flex: 1,
              child: Option('0-9', passwordAttributes.hasNumbers),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Option('a-z', passwordAttributes.hasLowerCase),
            ),
            Expanded(
              flex: 1,
              child: Option('!@#\$%^&*', passwordAttributes.hasSpecialChars),
            ),
          ],
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        // title
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, bottom: 8.0, top: 8.0),
          child: getTitle('Password Generator'),
        ),


        // linie de despartire
        Divider(
          height: 3.0,
          thickness: 2.0,
        ),

        // afisare parola generata
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: ButtonTheme(
                height: 40.0,
                child: FlatButton(
                  child: Text(
                    generatedPassword,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  color: my_grey,
                  onPressed: () {},
                )),
          ),
        ),

        // butoane REGENERARE + COPY
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // REGENERATE
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: RaisedButton(
                  color: theme_color,
                  splashColor: Colors.yellow,
                  child: Text(
                    'REGENERATE',
                    style: TextStyle(fontWeight: FontWeight.bold, color: white),
                  ),
                  onPressed: () {
                    setState(() {
                      tryRegeneratePassword(passwordAttributes)
                          .then((val) => setState(() {
                                generatedPassword = val;
                              }));
                    });
                  },
                ),
              ),
            ),

//            Expanded(
//              flex: 1,
//              child: Text('alexandra'),
//            ),

            // COPY
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: FlatButton(
                  child: Text(
                    'COPY',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: theme_color),
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: generatedPassword));
                  },
                ),
              ),
            ),
          ],
        ),

        // MINIMUM SPECIAL SI MINIMUM NUMBERS
        Row(
          children: <Widget>[
            // MINIMUM numbers
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataField('Minimum numbers'),
                )),

            // MINIMUM specials
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DataField('Minimum special'),
              ),
            ),
          ],
        ),

        Row(
          children: <Widget>[
            // length field
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DataField('Length'),
              ),
            ),

            // special options field
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 8, right: 4),
                child: Options(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<String> tryRegeneratePassword(PasswordAttributes passAttr) async {
    var err = await onRegeneratePassword(passAttr);
    if (err == null) {
    } else {
      setState(() {});
    }

    return err;
  }

  Future<String> onRegeneratePassword(PasswordAttributes passAttr) async {
    // treaba de backend
    String genrated_pass = PasswordGenerator.generatePassword(passAttr);

    return genrated_pass;
  }
}
