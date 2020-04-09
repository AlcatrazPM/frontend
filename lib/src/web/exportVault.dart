import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum CriptoType {
  DaCuZaru,
  DaCuBanu,
  RandomOrg
}

class ExportVault extends StatefulWidget {

  @override
  _ExportVaultState createState() => _ExportVaultState();
}

class _ExportVaultState extends State<ExportVault> {
  double leftPadding = 32.0;

  CriptoType _selectedCripto;
  List<DropdownMenuItem<CriptoType>> listaCripto;
  String masterPasswordString;

  @override
  void initState() {
    _selectedCripto = CriptoType.DaCuZaru;
    listaCripto = new List<DropdownMenuItem<CriptoType>>();
    listaCripto.add(DropdownMenuItem(value: CriptoType.DaCuZaru, child: Text("DaCuZaru"),));
    listaCripto.add(DropdownMenuItem(value: CriptoType.DaCuBanu, child: Text("DaCuBanu"),));
    listaCripto.add(DropdownMenuItem(value: CriptoType.RandomOrg, child: Text("RandomOrg"),));
    masterPasswordString = '';
    super.initState();
  }

  Widget DataField(String title) {
    return TextFormField(
      //autofocus: true,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
      ],
      cursorColor: Colors.amber,
      style: TextStyle(height: 1.0),
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      ),
      onChanged: (String stringNou){
        setState(() {
          masterPasswordString = stringNou;
          print(masterPasswordString);
        });
      },
      obscureText: true,
    );
  }

  Widget build(BuildContext context) {
    return Column (
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16.0, left: leftPadding),
          child: Text(
            "Export Vault",
            style: TextStyle (
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),

        Divider(height: 3, thickness: 2,),

        Padding(
          padding: EdgeInsets.only(left: leftPadding, top: 20),
          child: Text("Please enter your Master Password in order to export your vault.\n"),
        ),

        //Here you write your password.
        Padding(
          padding: EdgeInsets.only(left: leftPadding, top: 10, bottom: leftPadding),
          child: Row (
            children: <Widget>[
              Expanded(
                flex: 4,
                child: DataField("Master Password"),
              ),
              Expanded(
                flex: 6,
                child: SizedBox(),
              ),
            ],
          ),
        ),

        //Here is the DropDownButton
        Padding(
          padding: EdgeInsets.only(left: leftPadding, bottom: leftPadding),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: DropdownButtonFormField(
                  decoration: InputDecoration (
                    labelText: "Please select cripting method",
                  ),
                  value: _selectedCripto,
                  items: listaCripto,
                  hint: Text("This is a hint."),
                  onChanged: (CriptoType nouAles){
                    setState(() {
                      _selectedCripto = nouAles;
                    });
                  },
                ),
              ),
              Expanded(
                flex: 6,
                child: SizedBox(),
              ),
            ],
          ),
        ),
        //Here ENDS the DropDownButton

        //Here starts the submit button
        Padding(
          padding: EdgeInsets.only(left: leftPadding, top: 20.0),
          child: RaisedButton (
            child: Text (
              "Export"
            ),
            onPressed: (){},
            color: Colors.blueAccent,
            splashColor: Colors.yellow,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }
}