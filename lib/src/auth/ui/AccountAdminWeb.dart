import 'package:alkatrazpm/src/ui_utils/UIUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountAdminWeb extends StatefulWidget {
  @override
  _AccountAdminWebState createState() => _AccountAdminWebState();
}

class _AccountAdminWebState extends State<AccountAdminWeb> {
  TextEditingController chg_email_password;
  TextEditingController chg_email_new_email;
  TextEditingController chg_pass_current_pass;
  TextEditingController chg_pass_new_pass;
  TextEditingController chg_pass_new_pass_confim;

  @override
  void initState() {
    chg_email_new_email = new TextEditingController();
    chg_email_password = new TextEditingController();
    chg_pass_current_pass = new TextEditingController();
    chg_pass_new_pass = new TextEditingController();
    chg_pass_new_pass_confim = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        UiUtils.showDetailsSmall(context)? Container() : Spacer(),
        UiUtils.showDetails(context)
            ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(5),
          ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Settings"),
                        ),
                        Container(
                          height: 3,
                          width: 120,
                          color: Colors.grey
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right:8.0),
                                child: Icon(Icons.settings),
                              ),
                              Text("psdfjnksjfl")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right:8.0),
                                child: Icon(Icons.settings),
                              ),
                              Text("jfnkjnd     ")
                            ],
                          ),
                        ),
                      ],
                    ),
                ),
              ),
            )
            : Container(),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Container(
            width: UiUtils.adaptableWidth(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Change email"),
                Container(
                  color: Colors.grey,
                  width: 300,
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
                  child: TextFormField(
                    controller: chg_email_password,
                    decoration: InputDecoration(labelText: "Master passord"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: chg_email_new_email,
                    decoration: InputDecoration(labelText: "New email"),
                  ),
                ),
              ],
            ),
          ),
        ),
        Spacer(flex: UiUtils.showDetailsSmall(context)? 1 : 2),
      ],
    );
  }
}
