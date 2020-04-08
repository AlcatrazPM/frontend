import 'package:flutter/material.dart';

class PasswordGenerator extends StatefulWidget {
  @override
  _PasswordGenerator createState() => _PasswordGenerator();
}

class _PasswordGenerator extends State<PasswordGenerator> {
  // culori folosite
  Color my_grey = Colors.grey[300];
  Color light_blue = Colors.lightBlueAccent[100];
  Color theme_color = Colors.blue;

  // latimea coloanei
  double maxWidth = 800;

  // pentru switchurile de optiuni
  bool switch_AZ = false;
  bool switch_az = false;
  bool switch_09 = false;
  bool switch_others = false;

  // procentul de umplere al coloanei
  final int filling = 45;

  int column1_ratio = 15;
  int column2_ratio = 20;
  int column3_ratio = 45;
  int column4_ratio = 20;

  // data field
  Widget DataField(String title) {
    return TextFormField(
      autofocus: true,
      cursorColor: Colors.amber,
      style: TextStyle(height: 1.0),
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(borderSide: BorderSide(color: theme_color)),
      ),
    );
  }

  // widget pentru optimile suplimentare de generare a parolei
  Widget Option(String title, bool boolVal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title),
        Switch(
          value: boolVal,
          activeColor: theme_color,
          onChanged: (bool value) {
            setState(() {
              switch (title) {
                case 'A-Z':
                  switch_AZ = value;
                  break;
                case 'a-z':
                  switch_az = value;
                  break;
                case '0-9':
                  switch_09 = value;
                  break;
                case '!@#\$%^&*':
                  switch_others = value;
                  break;
              }
            });
          },
        ),
      ],
    );
  }

  Widget Options() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 50,
              child: Option('A-Z', switch_AZ),
            ),
            Expanded(
              flex: 50,
              child: Option('0-9', switch_09),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 50,
              child: Option('a-z', switch_az),
            ),
            Expanded(
              flex: 50,
              child: Option('!@#\$%^&*', switch_others),
            ),
          ],
        ),
      ],
    );
  }

  // luat de la mihai
  Widget settingsButton(String text) {
    return Row(
      children: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Row(
            children: <Widget>[
              Icon(
                Icons.favorite,
                color: my_grey,
              ),
              Text(text),
            ],
          ),
        ),
      ],
    );
  }

  // for the additional options on the left
  Widget customCard() {
    return Container(
      width: 200.0,
      height: 250.0,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        //color: Colors.purpleAccent,
        borderRadius: new BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Tools'),
          ),
          Divider(
            height: 3,
            thickness: 2,
          ),

          //Here the buttons start
          settingsButton('Password generator'),
          settingsButton('Export Data'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              // coloana goala
              Expanded(
                flex: 15,
                child: Column(),
              ),

              // cutie cu setari
              Expanded(
                flex: 20,
                child: Column(
                  children: <Widget>[
                    customCard(),
                  ],
                ),
              ),

              // coloana principala
              Expanded(
                flex: 45,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // title
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Password Generator',
                        textScaleFactor: 1.5,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      // linie de despartire
                      Divider(
                        color: my_grey,
                        height: 2,
                        thickness: 4,
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      // afisare parola generata
                      ButtonTheme(
                          minWidth: maxWidth,
                          height: 40.0,
                          child: FlatButton(
                            child: Text(
                              'hwjfuli3484pf',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            ),
                            color: my_grey,
                            onPressed: () {},
                          )),
                      SizedBox(
                        height: 10,
                      ),

                      // buton "REGENERARE"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: maxWidth * 2 / 5,
                            child: RaisedButton(
                              color: theme_color,
                              child: Text(
                                'REGENERATE',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              onPressed: () => {},
                            ),
                          ),
                          ButtonTheme(
                            minWidth: maxWidth * 2 / 5,
                            child: FlatButton(
                              //color: theme_color,
                              child: Text(
                                'COPY',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: theme_color),
                              ),
                              onPressed: () => {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      // MINIMUM SPECIAL SI MINIMUM NUMBERS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            flex: 45,
                            child: DataField('Minimum numbers'),
                          ),
                          Expanded(
                            flex: 10,
                            child: Column(),
                          ),
                          Expanded(
                            flex: 45,
                            child: DataField('Minimum Special'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            flex: 45,
                            child: DataField('Length'),
                          ),
                          Expanded(
                            flex: 10,
                            child: Column(),
                          ),
                          Expanded(
                            flex: 45,
                            child: Options(),
                          ),
                        ],
                      ),
                    ]),
              ),

              // coloana goala
              Expanded(
                flex: 20,
                child: Column(),
              ),
            ],
          )),
    );
  }
}
