import 'package:alkatrazpm/src/ui_utils/UiCommon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginFragment extends StatefulWidget {
  final Future<String> Function(String username, String password)
      onLoginClicked;
  final void Function() changeFragment;

  LoginFragment(this.onLoginClicked, {this.changeFragment});

  @override
  _LoginFragmentState createState() => _LoginFragmentState();
}

class _LoginFragmentState extends State<LoginFragment> {
  TextEditingController password, username;
  String error = "";

  @override
  void initState() {
    password = TextEditingController();
    username = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
              labelText: "Username", prefixIcon: Icon(Icons.account_circle)),
        ),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              labelText: "Password", prefixIcon: Icon(Icons.security)),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: UiCommon.outlineButton(context,
            onPressed: () {
              doLogin(password.text, username.text);
            },
            text: "Login",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text("Don't have an account?"),
        ),
        UiCommon.flatButton(context,
          onPressed: () {
            if (widget.changeFragment != null) {
              widget.changeFragment();
            }
          },
          text: "register",
        ),
      ],
    );
  }

  void doLogin(String username, String password) async {
    String error = await widget.onLoginClicked(username, password);
    if (error != "") {
      // to do
    }
  }
}
