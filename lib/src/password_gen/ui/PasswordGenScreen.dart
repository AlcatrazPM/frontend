import 'package:alkatrazpm/src/ui_utils/UIUtils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PasswordGenScreen extends StatefulWidget {
  @override
  _PasswordGenScreenState createState() => _PasswordGenScreenState();
}

class _PasswordGenScreenState extends State<PasswordGenScreen> {
  TextEditingController generatedPassword;
  double length = 12;
  bool az = false;
  bool AZ = false;
  bool digits = false;
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
                  IconButton(icon: Icon(Icons.close),
                  onPressed: (){
                    Navigator.of(context, rootNavigator: true).pop();
                  },),
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
      body: SingleChildScrollView(
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
                            onPressed: () {},
                            child: Text("Regenerate"),
                          ),
                        ),
                        Expanded(
                            child: FlatButton(
                                onPressed: () {}, child: Text("Copy")))
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
                              setState(() {});
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
                                  setState(() {});
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
                                  setState(() {});
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
                                  setState(() {});
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
                                  setState(() {});
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
    );
  }
}
