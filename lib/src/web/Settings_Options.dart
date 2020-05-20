import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum LockTime { OneMin, TwoMin, ThreeMin }

enum CriptoType { DaCuZaru, DaCuBanu, RandomOrg }

class OptionsSettings extends StatefulWidget {
  @override
  _OptionsSettingsState createState() => _OptionsSettingsState();
}

class _OptionsSettingsState extends State<OptionsSettings> {
  double leftPadding;
  LockTime _selectedTime;
  List<DropdownMenuItem<LockTime>> listLockTime;

  TextEditingController _masterPassword;
  TextEditingController _kdfIterations;

  bool isValid;

  CriptoType _selectedAlgo;
  List<DropdownMenuItem<CriptoType>> listCriptoType;

  @override
  void initState() {
    leftPadding = 8.0;
    _selectedTime = getUserSelectedTime();

    _masterPassword = new TextEditingController();
    _kdfIterations = new TextEditingController();

    listLockTime = new List<DropdownMenuItem<LockTime>>();
    listLockTime.add(DropdownMenuItem<LockTime>(
        value: LockTime.OneMin, child: Text("One Minute")));
    listLockTime.add(DropdownMenuItem<LockTime>(
        value: LockTime.TwoMin, child: Text("Two Minutes")));
    listLockTime.add(DropdownMenuItem<LockTime>(
        value: LockTime.ThreeMin, child: Text("Three Minutes")));

    _selectedAlgo = getUserSelectedAlgo();
    listCriptoType = new List<DropdownMenuItem<CriptoType>>();
    listCriptoType.add(DropdownMenuItem<CriptoType>(
      value: CriptoType.DaCuZaru,
      child: Text("Da Cu Zaru"),
    ));
    listCriptoType.add(DropdownMenuItem<CriptoType>(
      value: CriptoType.DaCuBanu,
      child: Text("Da Cu Banu"),
    ));
    listCriptoType.add(DropdownMenuItem<CriptoType>(
      value: CriptoType.RandomOrg,
      child: Text("Random Punct Org"),
    ));

    loadNrIterationsFromServer();

    isValid = false;

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 8.0),
          child: getHeading("Options", context),
        ),
        Divider(
          height: 3.0,
          thickness: 2.0,
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Lock Options",
                  ),
                  value: _selectedTime,
                  items: listLockTime,
                  onChanged: (LockTime aux) {
                    setState(() {
                      _selectedTime = aux;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                color: Colors.blue,
                child: SizedBox(),
              ),
            )
          ],
        ),

        ///////////////////Here is my button
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 20.0, bottom: 8.0),
          child: createButton("SAVE", () {
            setState(() {
              onSaveLockOptions(_selectedTime);
            });
          }),
        ),

        Container(
          padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 20.0),
          child: getHeading("Encryption Key Settings", context),
        ),
        Divider(
          height: 3.0,
          thickness: 2.0,
        ),

        Container(
          padding: EdgeInsets.only(left: 8.0, top: leftPadding),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: DataField("Master Password", _masterPassword, true),
              ),
              Expanded(
                flex: 6,
                child: SizedBox(),
              )
            ],
          ),
        ),

        //Creates the Line containing a dropdown and a textField with info about KDF algo.
        createKDF((x) {
          setState(() {
            _selectedAlgo = x;
          });
        }, _selectedAlgo, listCriptoType, "KDF Algorithm", "KDF Iterations",
            _kdfIterations),
        ///////////////////////////end of createKDF
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: createButton("SAVE", () {
            if (isValid == true) {
              setState(() {
                onSaveKDF();
              });
            } else {
              print("Nu are voie sa apese\n");
            }
          }),
        )
      ],
    );
  }

//  Widget getMyDropDown() {
//    return  Padding(
//      padding: EdgeInsets.only(left: leftPadding, bottom: leftPadding),
//      child: Row(
//        children: <Widget>[
//          Expanded(
//            flex: 4,
//            child: DropdownButtonFormField(
//              decoration: InputDecoration (
//                labelText: "Please select cripting method",
//              ),
//              value: _selectedTime,
//              items: listLockTime,
//              hint: Text("This is a hint."),
//              onChanged: (LockTime nouAles){
//                setState(() {
//                  _selectedTime = nouAles;
//                });
//              },
//            ),
//          ),
//          Expanded(
//            flex: 6,
//            child: SizedBox(),
//          ),
//        ],
//      ),
//    );
//  }

  Widget createKDF(func(var x), var value, List itms, String titleAlgo,
      String titleIterations, TextEditingController _control) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.all(0.0),
              child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: titleAlgo,
                  ),
                  value: value,
                  items: itms,
                  onChanged: (aux) {
                    func(aux);
                  }),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.only(left: 60.0, right: 40.0, top: 10.0),
              child: DataField(titleIterations, _control, false),
            ),
          )
        ],
      ),
    );
  }

  Widget createButton(String title, func()) {
    return Container(
      padding: EdgeInsets.only(
        left: 8.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 12,
            child: RaisedButton(
              onPressed: () {
                func();
              },
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              color: Colors.blue,
            ),
          ),
          Expanded(
            flex: 85,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget getHeading(String tit, BuildContext context) {
    return Row(
      children: <Widget>[
        getTitle(tit),
        Spacer(),
      ],
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

  Widget DataField(
      String title, TextEditingController _controller, bool isPassword) {
    return TextFormField(
      //autofocus: true,
      controller: _controller,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
      ],
      cursorColor: Colors.amber,
      style: TextStyle(height: 1.0),
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      ),

      validator: (input) {
        final isDigitsOnly = int.tryParse(input);

        //sets a variable so i know if the input is valid
        isDigitsOnly == null ? isValid = false : isValid = true;

        return isDigitsOnly == null ? 'Input needs to be digits only' : null;
      },
      autovalidate: !isPassword,
      onChanged: (String aux) {},
      obscureText: isPassword,
    );
  }

  //Returneaza de la server, timpul selectat de user
  LockTime getUserSelectedTime() {
    return LockTime.OneMin;
  }

  //returneaza de la server, tipul de criptare
  CriptoType getUserSelectedAlgo() {
    return CriptoType.DaCuZaru;
  }

  //trimite la server noul tip de LockTime (s-a apasat Save)
  void onSaveLockOptions(LockTime aux) {
    print("Saving Lock Optioons");
  }

  //Trimite la server noile date (algoritmul selectat si nr de iteratii)
  void onSaveKDF() {
    //Daca se apeleaza asta, inseamna ca nrIterations este un string valid.

    print("Are voie sa apese.");
    print(_kdfIterations.text);
    print(_selectedAlgo);
    print(_masterPassword.text);
    //_kdfIterations ->TextEditingController, contine nr de iteratiim apelezi functia int.tryParse(texT) pe el
    //_selectedAlgo  -> CryptoType , contine tipul de algo
    //_masterPassword ->TextEditingController, contine master password
  }

  //ia de la server nr de iteratii corespondent userului
  void loadNrIterationsFromServer() {
    _kdfIterations.text = "10";
  }
}
