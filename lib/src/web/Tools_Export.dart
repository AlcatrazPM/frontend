import 'package:alkatrazpm/src/accounts/model/Account.dart';
import 'package:alkatrazpm/src/accounts/service/AccountsService.dart';
import 'package:alkatrazpm/src/auth/model/AuthCredentials.dart';
import 'package:alkatrazpm/src/auth/service/AuthService.dart';
import 'package:alkatrazpm/src/dependencies/Dependencies.dart';
import 'package:alkatrazpm/src/file_saver/FileSaver.dart';
import 'package:alkatrazpm/src/ui_utils/Loading.dart';
import 'package:alkatrazpm/src/ui_utils/SnackBarUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum CriptoType { DaCuZaru, DaCuBanu, RandomOrg }

enum ExportType { Json, Csv }

class ExportVault extends StatefulWidget {
  @override
  _ExportVaultState createState() => _ExportVaultState();
}

class _ExportVaultState extends State<ExportVault> {
  double leftPadding = 8.0;
  double topTitlePadding = 8.0;
  LoadingController loadingController;

  CriptoType _selectedCripto;
  List<DropdownMenuItem<CriptoType>> listaCripto;

  ExportType _selectedExport;
  List<DropdownMenuItem<ExportType>> listaExportType;

  String masterPasswordString;

  @override
  void initState() {
    //To remove these....
    loadingController = LoadingController();
    _selectedCripto = CriptoType.DaCuZaru;
    listaCripto = new List<DropdownMenuItem<CriptoType>>();
    listaCripto.add(DropdownMenuItem(
      value: CriptoType.DaCuZaru,
      child: Text("DaCuZaru"),
    ));
    listaCripto.add(DropdownMenuItem(
      value: CriptoType.DaCuBanu,
      child: Text("DaCuBanu"),
    ));
    listaCripto.add(DropdownMenuItem(
      value: CriptoType.RandomOrg,
      child: Text("RandomOrg"),
    ));
    //untill here....
    _selectedExport = ExportType.Json;
    listaExportType = new List<DropdownMenuItem<ExportType>>();
    listaExportType.add(DropdownMenuItem(
      value: ExportType.Json,
      child: Text("JSON"),
    ));
    listaExportType.add(DropdownMenuItem(
      value: ExportType.Csv,
      child: Text("CSV"),
    ));

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
      onChanged: (String stringNou) {
        setState(() {
          masterPasswordString = stringNou;
          //print(masterPasswordString);
        });
      },
      obscureText: true,
    );
  }

  Widget getTitle(String tit) {
    return Text(
      tit,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // title
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
          child: getTitle('Export Vault'),
        ),

        Divider(
          height: 3,
          thickness: 2,
        ),

        Padding(
          padding: EdgeInsets.only(left: leftPadding, top: 20),
          child: Text(
              "Please enter your Master Password in order to export your vault.\n"),
        ),

        //Here you write your password.
        Padding(
          padding:
              EdgeInsets.only(left: leftPadding, top: 10, bottom: leftPadding),
          child: Row(
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
                  decoration: InputDecoration(
                    labelText: "Please select cripting method",
                  ),
                  value: _selectedExport,
                  items: listaExportType,
                  hint: Text("This is a hint."),
                  onChanged: (ExportType nouAles) {
                    setState(() {
                      _selectedExport = nouAles;
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
          child: Loading(
            controller: loadingController,
            child: RaisedButton(
              child: Text("Export",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              onPressed: () {
                submitExport(masterPasswordString, _selectedExport);
              },
              color: Colors.blue,
              splashColor: Colors.yellow,
            ),
          ),
        ),
      ],
    );
  }

  //BACKEND---------------------------------------------
  Future<String> submitExport(String masterPassword, ExportType tipExp) async {
    loadingController.setLoading();
    var authService = deps.get<AuthService>();
    var user = await authService.loggedUser();
    try {
      await authService
          .login(AuthCredentials.login(user.email, masterPassword));
      saveAccountsToFile(tipExp);
    } catch (e) {
      loadingController.setDone();
      SnackBarUtils.showError(context, "Wrong password");
    }

    return "Va pup, frumosilor.\n";
  }

  Future<void> saveAccountsToFile(ExportType exportType) async {
    var accounts =
        await deps.get<AccountsService>().getAccounts(fromCache: true);
    var text = "";
    String fileName;
    switch(exportType){
      case ExportType.Csv:{
        fileName = "accounts.csv";
        text += "website, username, password, isFavorite\n";
        for(Account a in accounts){
          text += "${a.website}, ${a.username}, ${a.password}, ${a
              .isFavorite}\n";
        }
        break;
      }
      case ExportType.Json:
        text += "[\n";
        for(Account a in accounts){
          text +=
              "   {\n"
              "       \"website\":\"${a.website}\",\n"
              "       \"username\":\"${a.username}\",\n"
              "       \"password\":\"${a.password}\",\n"
              "       \"isFavorite\":\"${a.isFavorite}\"\n"
              "   },\n";
        }
        text = text.substring(0, text.length-2);
        text += "\n]";
        fileName = "accounts.json";
        break;
    }
    deps.get<FileSaver>().saveFile(fileName, text);
    loadingController.setDone();
    return Future.value();
  }
}
