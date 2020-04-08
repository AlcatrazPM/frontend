import 'package:alkatrazpm/src/ui_utils/UiCommon.dart';
import 'package:flutter/material.dart';

class RegisterFragment extends StatefulWidget {
  final Future<String> Function(String email, String username, String password)
      onRegisterClicked;
  final void Function() changeFragment;
  final bool darkTheme;

  RegisterFragment(this.onRegisterClicked, {this.changeFragment, this.darkTheme = true});

  @override
  _RegisterFragmentState createState() => _RegisterFragmentState();
}

class _RegisterFragmentState extends State<RegisterFragment> {
  TextEditingController password, confirmPassword, username, email;
  String error = "";

  @override
  void initState() {
    password = TextEditingController();
    confirmPassword = TextEditingController();
    username = TextEditingController();
    email = TextEditingController();
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
              labelText: "Email", prefixIcon: Icon(Icons.email)),
        ),
        TextFormField(
          decoration: InputDecoration(
              labelText: "Username", prefixIcon: Icon(Icons.account_circle)),
        ),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              labelText: "Password", prefixIcon: Icon(Icons.security)),
        ),
        TextFormField(
          obscureText: true,
          autovalidate: true,
          validator: (password) {
            if (password == null || password == "") return null;
            return password == confirmPassword.text
                ? null
                : "passords do not match";
          },
          decoration: InputDecoration(
            labelText: "Confirm Password",
            prefixIcon: Icon(Icons.check),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: UiCommon.outlineButton(context,
            onPressed: () {
              doRegister(email.text, username.text, password.text);
            },
            text: "Register",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text("Already have an account?"),
        ),
        UiCommon.flatButton(context,
            onPressed: () {
              if (widget.changeFragment != null) {
                widget.changeFragment();
              }
            },
            text: "login"),
      ],
    );
  }

  void doRegister(String email, String username, String password) async {
    String error = await widget.onRegisterClicked(email, username, password);
    if (error != "") {
      // to do
    }
  }
}
