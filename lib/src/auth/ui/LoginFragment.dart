import 'package:alkatrazpm/src/ui_utils/Loading.dart';
import 'package:alkatrazpm/src/ui_utils/UiCommon.dart';
import 'package:alkatrazpm/src/utils/Validators.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginFragment extends StatefulWidget {
  final Future<void> Function(String username, String password) onLoginClicked;
  final void Function() changeFragment;

  LoginFragment(this.onLoginClicked, {this.changeFragment});

  @override
  _LoginFragmentState createState() => _LoginFragmentState();
}

class _LoginFragmentState extends State<LoginFragment> {
  TextEditingController password, username;
  String error = "";
  LoadingController loadingController = LoadingController();

  GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();

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
        Form(
          key: _emailKey,
          child: TextFormField(
            controller: username,
            validator: Validators.emailValidator,
            onChanged: (s){
              _emailKey.currentState.validate();
            },
            decoration: InputDecoration(
                labelText: "Email", prefixIcon: Icon(Icons.account_circle)),
          ),
        ),
        Form(
          key: _passwordKey,
          child: TextFormField(
            controller: password,
            obscureText: true,
            textInputAction: TextInputAction.send,
            onFieldSubmitted: (v){
              doLogin(context, username.text, password.text);
            },
            onChanged: (s){
              _passwordKey.currentState.validate();
            },
            validator: Validators.passwordValidator,
            decoration: InputDecoration(
                labelText: "Password", prefixIcon: Icon(Icons.security)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Loading(
            loading: Hero(
              tag: "progress",
              child: CircularProgressIndicator(),
            ),
            controller: loadingController,
            child: UiCommon.outlineButton(
              context,
              onPressed: () {
                doLogin(context, username.text, password.text);
              },
              text: "Login",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text("Don't have an account?"),
        ),
        UiCommon.flatButton(
          context,
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

  void doLogin(BuildContext context, String email, String password) async {
    if (validate()) {
      loadingController.setLoading();
      await widget.onLoginClicked(email, password);
      loadingController.setDone();
    }
  }

  bool validate(){
    var email = _emailKey.currentState.validate();
    var pass = _passwordKey.currentState.validate();
    return email && pass;
  }
}
