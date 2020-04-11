import 'package:alkatrazpm/src/ui_utils/UiCommon.dart';
import 'package:alkatrazpm/src/utils/Validators.dart';
import 'package:flutter/material.dart';

class RegisterFragment extends StatefulWidget {
  final Future<void> Function(String email, String username, String password)
      onRegisterClicked;
  final void Function() changeFragment;
  final bool darkTheme;

  RegisterFragment(this.onRegisterClicked,
      {this.changeFragment, this.darkTheme = true});

  @override
  _RegisterFragmentState createState() => _RegisterFragmentState();
}

class _RegisterFragmentState extends State<RegisterFragment> {
  TextEditingController password, confirmPassword, username, email;
  String error = "";
  GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  GlobalKey<FormState> _confirmPasswordey = GlobalKey<FormState>();

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
        Form(
          key: _emailKey,
          child: TextFormField(
            controller: email,
            onChanged: (s) {
              _emailKey.currentState.validate();
            },
            validator: Validators.emailValidator,
            decoration: InputDecoration(
                labelText: "Email", prefixIcon: Icon(Icons.email)),
          ),
        ),
        Form(
          key: _passwordKey,
          child: TextFormField(
            obscureText: true,
            controller: password,
            onChanged: (s) {
              _passwordKey.currentState.validate();
            },
            validator: Validators.passwordValidator,
            decoration: InputDecoration(
                labelText: "Password", prefixIcon: Icon(Icons.security)),
          ),
        ),
        Form(
          key: _confirmPasswordey,
          child: TextFormField(
            controller: confirmPassword,
            obscureText: true,
            validator: (pass) {
              if (confirmPassword.text != password.text) return "passwords do not"
                  " match";
              return null;
            },
            onChanged: (s) {
              _confirmPasswordey.currentState.validate();
            },
            decoration: InputDecoration(
              labelText: "Confirm Password",
              prefixIcon: Icon(Icons.check),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: UiCommon.outlineButton(
            context,
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
        UiCommon.flatButton(context, onPressed: () {
          if (widget.changeFragment != null) {
            widget.changeFragment();
          }
        }, text: "login"),
      ],
    );
  }

  void doRegister(String email, String username, String password) async {
    if (_validate()) {
      widget.onRegisterClicked(email, username, password);
    }
  }

  bool _validate() {
    var email = _emailKey.currentState.validate();
    var password = _passwordKey.currentState.validate();
    var confirm = _confirmPasswordey.currentState.validate();
    return email && password && confirm;
  }


}
