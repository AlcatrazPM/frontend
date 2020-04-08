import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiCommon {
  static FlatButton flatButton(BuildContext context,
          {Function() onPressed, String text, color: Colors.white}) =>
      FlatButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).brightness != Brightness.light
                  ? color
                  : Colors.blue,
              fontWeight: FontWeight.bold),
        ),
      );

  static Widget outlineButton(
    BuildContext context, {
    Function() onPressed,
    String text,
  }) {
    return Theme.of(context).brightness != Brightness.light
        ? OutlineButton(
            color: Colors.white,
            borderSide: BorderSide(color: Colors.white, width: 3.0),
            highlightedBorderColor: Colors.white,
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          )
        : RaisedButton(
            onPressed: onPressed,
            color: Colors.blue,
            child: Text(text),
          );
  }
}
