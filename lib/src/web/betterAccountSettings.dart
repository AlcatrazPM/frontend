import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BetterAccountSettings extends StatelessWidget {

  final int firstFlex = 15;
  final int secondFlex = 20;
  final int thirdFlex = 45;
  final int fourthFlex = 20;

  final int emailTextFlex = 7;
  final int emailRowFlex = 30;
  final int masterTextFlex = 10;
  final int masterRowFlex = 35;
  final int emptyRowFlex = 18;

  Widget DataField(String title) {
    return TextFormField(
      //autofocus: true,
      cursorColor: Colors.amber,
      style: TextStyle(height: 1.0),
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      ),
    );

  }

  // luat de la mihai
  Widget settingsButton(String text) {
    return Row (
      children: <Widget>[
        FlatButton(
          onPressed: (){},
          child: Row (
            children: <Widget>[
              Icon(Icons.favorite, color: Colors.grey[300],),
              Text(text),
            ],
          ),
        ),
      ],
    );
  }


  // for the additional options on the left
  Widget customCard() {
    return Container (
      width: 200.0,
      height: 250.0,
      margin: EdgeInsets.all(20),

      decoration: BoxDecoration (
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
          Divider(height: 3, thickness: 2,),

          //Here the buttons start
          settingsButton('Change email'),
          settingsButton('Master Password'),
        ],
      ),
    );
  }

  Widget smallButton(String text, Function func) {
    return Row (
      children: <Widget>[
        Expanded (
          flex: 3,
          child: RaisedButton (
            color: Colors.blue,
            child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
            onPressed: func,
          ),
        ),
        Expanded (
          flex: 7,
          child: SizedBox(),
        )
      ],
    );
  }

  Widget customDivider(double h) {
    return new SizedBox(
      height: h,
      child: new Center(
        child: new Container(
          margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
          height: 5.0,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget underlinedText(String text) {
    return Column (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle (
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Divider(height: 20, thickness: 3,),
        //customDivider(20),
      ],
    );
  }

  Widget build (BuildContext context) {
    //Inside the principal row, there are 4 column.
    //Third Column, from left to right, has 5 rows stacked.
    return Scaffold(
      body: Row (
        //This is the principal ROW. All columns reside here.
        //Space will be shared horizontally by columns.

        children: <Widget>[

          //First Empty Column
          Expanded (
            flex: firstFlex,
            child: Container(
              // color: Colors.green,
              child: Column(

              ),
            ),
          ),

          //Second Column, Contains some Settings Widget
          Expanded (
            flex: secondFlex,
            child: Container (
              //color: Colors.purpleAccent,
              child: Column(
                children: <Widget>[
                  customCard(),
                ],

              ),
            ),
          ),

          //Third Column, Here is the IMPORTANT stuff.
          Expanded (
            flex: thirdFlex,
            child: Container (
              //color: Colors.yellow,
              padding: EdgeInsets.all(10),
              child: Column (
                children: <Widget>[

                  //First Row, Title "Change-Email"
                  Expanded(
                    flex: emailTextFlex,
                    child: Column (
                      children: <Widget>[
                        underlinedText("Change-Email"),
                      ],
                    ),
                  ),

                  //Second Row, splitted in two columns.
                  Expanded(
                    flex: emailRowFlex,
                    child: Row (
                      children: <Widget>[

                        //First Column of the Splitted Row
                        Expanded (
                          flex: 1,
                          child: Container(
                            //color: Colors.blue,
                            child: Column(
                              //Here starts the first form.
                              children: <Widget>[
                                Form (
                                  child: Container (
                                    child: Expanded(
                                      child: ListView (
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DataField("Master Password"),
                                          ),
//                                          TextFormField (
//                                            decoration: InputDecoration(
//                                              hintText: "Master Password",
//                                            ),
//                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DataField("New E-mail"),
                                          ),
//                                          TextFormField (
//                                            decoration: InputDecoration(
//                                              hintText: "New E-mail",
//                                            ),
//                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: smallButton("SAVE", ()=>{}),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //Second Column of the Splitted Row
                        Expanded (
                          flex: 1,
                          child: Container(
                            //color: Colors.green,
                            child: Column(

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Third ROW, Titled "Change Master Password"
                  Expanded (
                    flex: masterTextFlex,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column (
                        children: <Widget>[
                          underlinedText("Change Master Password")
                        ],
                      ),
                    ),
                  ),

                  //Fourth Row, split in Two Columns
                  Expanded (
                    flex: masterRowFlex,
                    child: Row(

                      children: <Widget>[

                        //First column of the Row Master Password
                        Expanded(
                          flex: 45,
                          child: Container(
                            //color: Colors.red,
                            child: Column (
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DataField("Master Password"),
                                ),
//                                TextFormField(
//                                  decoration: InputDecoration(
//                                    hintText: "Current Master Password"
//                                  ),
//                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DataField("New Master Password"),
                                ),
//                                TextFormField(
//                                  decoration: InputDecoration(
//                                    hintText: "New Master Password",
//                                  ),
//                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: smallButton("Save", ()=>{}),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //Spacing between the 2 columns.
                        Expanded(
                          flex: 10,
                          child: SizedBox(),
                        ),

                        //Second Column of the Row Master Password
                        Expanded (
                          flex: 45,
                          child: Container(
                            //color: Colors.blue,
                            child: Column (
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DataField("Confirm New Master Password"),
                                ),
//                                TextFormField (
//                                  decoration: InputDecoration(
//                                    hintText: "Confirm New Master Password",
//                                  ),
//                                ),
                              ],

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //The last, EMPTY ROW.
                  Expanded (
                    flex: emptyRowFlex,
                    child: Row (),
                  ),
                ],
              ),
            ),
          ),

          //Fourth Column, here is EMPTY SPACE
          Expanded (
            flex: fourthFlex,
            child: Container (
              //color: Colors.red,/////////////////////////////////
              child: Column (

              ),
            ),
          ),

          //End of PRINCIPAL ROW
        ],
      ),
    );
  }
}