import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  // controllers for the data fields
  TextEditingController _masterPassword;
  TextEditingController _newEmail;
  TextEditingController _currentMasterPassword;
  TextEditingController _newMasterPassword;
  TextEditingController _confirmNewMasterPassword;

  // colors
  Color theme_color = Colors.blue;

  void initState() {
    _masterPassword = new TextEditingController();
    _newEmail = new TextEditingController();
    _currentMasterPassword = new TextEditingController();
    _newMasterPassword = new TextEditingController();
    _confirmNewMasterPassword = new TextEditingController();
    super.initState();
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

  // text form fields
  Widget DataField(String title, TextEditingController dataController) {
    return TextFormField(
      controller: dataController,
      cursorColor: Colors.amber,
      style: TextStyle(
        fontSize: 15.0,
      ),
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
        contentPadding: EdgeInsets.only(
          bottom: 10.0,
          left: 10.0,
        ),
      ),
      inputFormatters: [
        new LengthLimitingTextInputFormatter(30),
      ],
      onChanged: (String input_user) {
        //print(dataController.text);
      },
    );
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Change Email title
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, bottom: 8.0, top: 58.0),
          child: getTitle('Change Email'),
        ),
        Divider(
          height: 3.0,
          thickness: 2.0,
        ),

        // Master Password
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, top: 15.0, right: 400.0, bottom: 8.0),
          child: DataField('Master Password', _masterPassword),
        ),

        // New Email
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, top: 15.0, right: 400.0, bottom: 8.0),
          child: DataField('New Email', _newEmail),
        ),

        // Save button
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            color: theme_color,
            splashColor: Colors.yellow,
            child: Text(
              'SAVE',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onPressed: () {
              // trebuie sa dau mai departe _masterPassword.text si _newEmail.text
              onChangeEmail(_masterPassword.text, _newEmail.text);
            },
          ),
        ),

        // Change Master Password title
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 20.0, bottom: 8.0),
          child: getTitle('Change Master Password'),
        ),
        Divider(
          height: 3.0,
          thickness: 2.0,
        ),

        // Current Master Password data field
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, top: 15.0, right: 400.0, bottom: 8.0),
          child: DataField('Current Master Password', _currentMasterPassword),
        ),

        Row(
          children: <Widget>[
            // New Master Password data field
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, top: 8.0, right: 25.0, bottom: 8.0),
                child: DataField('New Master Password', _newMasterPassword),
              ),
            ),

            // Confirm New Master Password data field
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, top: 8.0, right: 25.0, bottom: 8.0),
                child: DataField(
                    'Confirm New Master Password', _confirmNewMasterPassword),
              ),
            ),
          ],
        ),

        // Save button
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            color: theme_color,
            splashColor: Colors.yellow,
            child: Text(
              'SAVE',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onPressed: () {
              // trebuie sa trimit mai departe _currentMasterPassword.text _newMasterPassword.text _confirmNewMasterPassword.text
              onChangeMasterPassword(_currentMasterPassword.text,
                  _newMasterPassword.text, _confirmNewMasterPassword.text);
            },
          ),
        ),
      ],
    );
  }

  ////////////////////////////////////////////
  void onChangeEmail(String masterPassword, String newEmail) {}

  void onChangeMasterPassword(String currentMasterPassword,
      String newMasterPassword, String confirmNewMasterPassword) {}
}
