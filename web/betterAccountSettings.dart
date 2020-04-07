import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BetterAccountSettings extends StatelessWidget {

  final int firstFlex = 15;
  final int secondFlex = 20;
  final int thirdFlex = 45;
  final int fourthFlex = 20;

  final int emailTextFlex = 7;
  final int emailRowFlex = 28;
  final int masterTextFlex = 7;
  final int masterRowFlex = 28;
  final int emptyRowFlex = 30;


  Widget settingsButton() {
    return Row (
      children: <Widget>[
//        Expanded (
//          flex: 1,
//          child: SizedBox(),
//        ),
        Expanded (
          flex: 9,
          child: FlatButton(
            onPressed: (){},
            child: Row (
              children: <Widget>[
                Icon(Icons.accessible_forward),
                Text("Press me"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget customCard() {
    return Container (

      width: 200.0,
      height: 250.0,
      margin: EdgeInsets.all(20),

      decoration: BoxDecoration (
        //color: Colors.purpleAccent,
        borderRadius: new BorderRadius.only(
            topLeft:  const  Radius.circular(10.0),
            topRight: const  Radius.circular(10.0)),
        border: Border.all(color: Colors.grey),
      ),

      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Settings"),
          ),
          Divider(height: 3, thickness: 2,),

          //Here the buttons start
          settingsButton(),
          settingsButton(),
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
            child: Text(text),
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
                                          TextFormField (
                                            decoration: InputDecoration(
                                              hintText: "Master Password",
                                            ),
                                          ),
                                          TextFormField (
                                            decoration: InputDecoration(
                                              hintText: "New E-mail",
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: smallButton("Save", ()=>{}),
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
                    child: Column (
                      children: <Widget>[
                        underlinedText("Change Master Password")
                      ],
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
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Current Master Password"
                                  ),
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "New Master Password",
                                  ),
                                ),
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
                                TextFormField (
                                  decoration: InputDecoration(
                                    hintText: "Confirm New Master Password",
                                  ),
                                ),
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