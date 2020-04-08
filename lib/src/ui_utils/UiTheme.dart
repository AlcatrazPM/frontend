import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiThemes{
  static ThemeData authTheme(BuildContext context){
    ThemeData themeData = Theme.of(context);
    return themeData.copyWith(
        primaryColorBrightness: Brightness.dark,
        accentColor: Colors.white,
        primaryColor: Colors.white,
        iconTheme: themeData.iconTheme.copyWith(color: Colors.white),
        textTheme: themeData.primaryTextTheme.copyWith().apply(
          decorationColor: Colors.white,
          displayColor: Colors.white,
          bodyColor: Colors.white,
        ),
        inputDecorationTheme: themeData.inputDecorationTheme.copyWith(
          focusColor: Colors.white70,
          focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red[400], width: 3)),
          errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red[400])),
          errorStyle: TextStyle(color: Colors.red[400], fontWeight: FontWeight.bold, fontSize: 15),
          labelStyle: TextStyle(color: Colors.white70),
        ),
        buttonTheme: themeData.buttonTheme.copyWith(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20,),
          ),
        ),
        accentColorBrightness: Brightness.dark,
        brightness: Brightness.dark);
  }


  static ThemeData webThemeScreen(BuildContext context){
    ThemeData data = Theme.of(context);
    return data.copyWith(
      inputDecorationTheme: data.inputDecorationTheme.copyWith(
        border: OutlineInputBorder()
      )
    );
  }

  static ThemeData authThemeLight(BuildContext context){
    ThemeData themeData = Theme.of(context);
    return themeData.copyWith(
        primaryColorBrightness: Brightness.light,
        accentColor: Colors.blue,
        primaryColor: Colors.blue,
        buttonTheme: themeData.buttonTheme.copyWith(
          buttonColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20,),
          ),
        ),
        accentColorBrightness: Brightness.light,
        brightness: Brightness.light);
  }
}