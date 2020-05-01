import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:alkatrazpm/src/web/Tools_PasswordGenerator.dart';
import 'package:alkatrazpm/src/web/Tools_Export.dart';

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
    isExportVaultPage = false;
    super.initState();
  }

  Widget ToolsPrompt() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 60.0, right: 20.0),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(width: 2, color: Colors.blue),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 8),
                  child: Text(
                    "TOOLS",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 3,
              thickness: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 0.5, bottom: 0.0),
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.storage),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Password Manager"),
                    ),
                  ],
                ),
                //color: isExportVaultPage ? Colors.white70 : Colors.blue,
                onPressed: () {
                  setState(() {
                    isExportVaultPage = false;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, right: 0.5),
              child: FlatButton(
               // color: isExportVaultPage ? Colors.blue : Colors.white70,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.import_export),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Export Vault"),
                    ),
                  ],
                ),
                onPressed: () {
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
              decoration: BoxDecoration(
//								border: Border.all(),
                  ),
              ////////Here starts the real stuff
              child: Row(
                children: <Widget>[
                  ////This is the column for the ToolsPrompt.
                  ////Here you select what widget to display.
                  Expanded(
                    flex: 1,
                    child: Container(
                      //color: Colors.red,
                      child: Column(
                        children: <Widget>[
                          ToolsPrompt(),
                        ],
                      ),
                    ),
                  ),
                  //This is the Export Vault OR the PasswordManager Widget
                  Expanded(
                    flex: 3,
                    child: isExportVaultPage
                        ? ExportVault()
                        : PasswordGeneratorWidget(),
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
