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
      title: Text("Add account"),
      content: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: <Widget>[
              TextField(
                controller: website,
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
                        icon: Icon(Icons.settings_backup_restore, color: Colors.blue,))),
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  Spacer(),
                  RaisedButton(
                    child: Text("Done"),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
