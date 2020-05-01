import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SnackBarUtils{
  static void showInfo(BuildContext context, String info){
    _show(context, info, " ", [Colors.blue, Colors.blue]);
  }
  static void showError(BuildContext context, String error){
    _show(context, "Ooopsie", error, [Colors.red, Colors.red]);
  }

  static void showConfirmation(BuildContext context, String message){
    Toast.show(message, context, backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  static void _show(BuildContext context, String title, String text,
      List<Color> colors){
    Flushbar(
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(8.0),
      borderRadius: 8,
      backgroundGradient: LinearGradient(
        colors: colors,
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: title,
      message: text,
    )..show(context);
  }
}