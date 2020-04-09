import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'exportVault.dart';

class ToolsMainPage extends StatefulWidget {

  @override
  _ToolsMainPageState createState() => _ToolsMainPageState();
}

class _ToolsMainPageState extends State<ToolsMainPage> {
  final boxWidth = 1000.0;
  final boxHeight = 800.0;

  bool isExportVaultPage;

  @override
  void initState() {
    isExportVaultPage = true;
    super.initState();
  }

  Widget ToolsPrompt() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 60.0, right: 20.0),
      child: Container (
        height: 300,
        decoration: BoxDecoration (
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),

          border: Border.all(color: Colors.black),
        ),
        child: Column (
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Tools",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 3, thickness: 3,),
            Padding(
              padding: const EdgeInsets.only( top: 8.0, left: 2.0, right: 2.0),
              child: FlatButton(
                child: Row (
                  children: <Widget>[
                    Icon(Icons.storage),
                    Text("Password Manager"),
                  ],
                ),
                color: isExportVaultPage ? Colors.white70 : Colors.blue,
                onPressed: (){
                  setState(() {
                    isExportVaultPage = false;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only( top: 8.0, left: 2.0, right: 2.0),
              child: FlatButton(
                color: isExportVaultPage ? Colors.blue : Colors.white70,
                child: Row (
                  children: <Widget>[
                    Icon(Icons.import_export),
                    Text("Export Vault"),
                  ],
                ),
                onPressed: (){
                  setState(() {
                    isExportVaultPage = true;
                  });
                },
              ),
            ),

          ],
        ),

      ),
    );
  }

  Widget build(BuildContext context) {
    //var screen_width = MediaQuery.of(context).size.width;
    //var screen_height = MediaQuery.of(context).size.height;
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: boxWidth,
              height: boxHeight,
              //color: Colors.black,
              decoration: BoxDecoration (
                border: Border.all(),
              ),
              ////////Here starts the real stuff
              child: Row(
                children: <Widget>[
                  ////This is the column for the ToolsPrompt.
                  ////Here you select what widget to display.
                  Expanded (
                    flex: 1,
                    child: Container(
                      //color: Colors.red,
                      child: Column (
                        children: <Widget>[
                          ToolsPrompt(),
                        ],
                      ),
                    ),
                  ),
                  //This is the Export Vault OR the PasswordManager Widget
                  Expanded (
                    flex: 3,
                    child: isExportVaultPage ? ExportVault() : Container(child: Text("Nu e nimic aici boss.\n"),),
                  ),
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}