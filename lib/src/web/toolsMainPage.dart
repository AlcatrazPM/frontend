import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToolsMainPage extends StatefulWidget {

  @override
  _ToolsMainPageState createState() => _ToolsMainPageState();
}

class _ToolsMainPageState extends State<ToolsMainPage> {
  final boxWidth = 1000.0;
  final boxHeight = 800.0;

  Widget ToolsPrompt() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 60.0, right: 20.0),
      child: Container (
        height: 300,
        decoration: BoxDecoration (
          border: Border.all(color: Colors.black),
        ),
      ),
    );
  }

  Widget ExportVault () {
    return Column (
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0),
          child: Text(
            "Export Vault",
            style: TextStyle (
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
        Divider(height: 2, thickness: 2,),
        Text("Ana are mere.\n"),
      ],
    );
  }

  Widget build(BuildContext context) {
    //var screen_width = MediaQuery.of(context).size.width;
    //var screen_height = MediaQuery.of(context).size.height;
    return Container(
      width: boxWidth,
      height: boxHeight,
      //color: Colors.black,
      decoration: BoxDecoration (
        border: Border.all(),
      ),
      child: Row(
        children: <Widget>[
          Expanded (
            flex: 1,
            child: Column (
              children: <Widget>[
                ToolsPrompt(),
              ],
            ),
          ),
          Expanded (
            flex: 3,
            child: ExportVault(),
          ),
        ],

      ),
    );
  }
}