import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Vault extends StatelessWidget {

  final int firstFlex = 15;
  final int secondFlex = 20;
  final int thirdFlex = 30;
  final int fourthFlex = 35;

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

  Widget customFilters() {
    return Container (

      width: 200.0,
      height: 350.0,
      margin: EdgeInsets.all(20),

      decoration: BoxDecoration (
        //color: Colors.purpleAccent,
        borderRadius: new BorderRadius.only(
            topLeft:  const  Radius.circular(10.0),
            topRight: const  Radius.circular(10.0),
            bottomLeft: const Radius.circular(10.0),
            bottomRight: const Radius.circular(10.0),
        ),
        border: Border.all(color: Colors.grey),
      ),

      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Filters",
              style: TextStyle (
                fontSize: 20,
              ),
            ),
          ),
          Divider(height: 3, thickness: 2,),

          //Here is the SEARCH FIELD
          SizedBox(
            height: 55,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField (
                decoration: InputDecoration (
                  prefixIcon: Icon(Icons.search),
                  //border: InputBorder.none,
                  focusedBorder: OutlineInputBorder (
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder (
                    borderSide: BorderSide(color: Colors.grey),
                  )
                ),
              ),
            ),
          ),

          //Here is the first button.
          settingsButton(),
          settingsButton(),

          Expanded(
            child: Container (
              padding: EdgeInsets.all(5.0),
              child: GridView.count (
                crossAxisCount: 3,
                crossAxisSpacing: 3.0,
                mainAxisSpacing: 3.0,
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  Icon(Icons.account_balance),
                  Icon(Icons.accessibility_new),
                  Icon(Icons.account_circle),
                ],
              ),
            ),
          ),
//          Container(
//          padding: EdgeInsets.all(16.0),
//    child: GridView.count(
//    crossAxisCount: 3,
//    crossAxisSpacing: 4.0,
//    mainAxisSpacing: 8.0,
//    children:
        ],
      ),
    );
  }

  Widget vaultCard () {
    return Container (
      width: 325,
      height: 125,
      //color: Colors.black,
      decoration: BoxDecoration (
        //color: Colors.purpleAccent,
        borderRadius: new BorderRadius.only(
            topLeft:  const  Radius.circular(10.0),
            topRight: const  Radius.circular(10.0),
            bottomLeft: const Radius.circular(10.0),
            bottomRight: const Radius.circular(10.0),
        ),
        border: Border.all(color: Colors.grey),
      ),

      //The main Row is splitted in 2 main Columns.
      //First column holds the picture.
      //Second column holds the data.
      child: Row (
        children: <Widget>[
          Expanded (
            flex: 35,
            child: Container(
            //  color: Colors.red,
              child: Column (
                children: <Widget>[
                  Expanded(
                    child: FittedBox (
                      fit: BoxFit.fill,
                      child: Icon(Icons.airline_seat_legroom_normal),
                    ),
                  ),
                ],

              ),
            ),
          ),
          Expanded (
            flex: 65,
            child: Container(
              //color: Colors.black,
              padding: EdgeInsets.all(10.0),
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: Text(
                      "Site",
                      style: TextStyle (
                        fontWeight: FontWeight.w500,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Text(
                      "Username",
                      style: TextStyle (
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 11,
                    child: Row (
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              "LOGIN",
                              style: TextStyle (
                                color: Colors.purple,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            onPressed: (){},
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              "PASSWORD",
                              style: TextStyle (
                                color: Colors.purple,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            onPressed: (){},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
              //color: Colors.green,
              child: Column(

              ),
            ),
          ),

          //Second Column, Contains some Settings Widget
          Expanded (
            flex: secondFlex,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
              child: Container (
                //color: Colors.purpleAccent,
                child: Column(
                  children: <Widget>[
                    customFilters(),
                  ],

                ),
              ),
            ),
          ),

          //Third Column, Here is the IMPORTANT stuff.
          Expanded (
            flex: thirdFlex,
            child: Container (
              //color: Colors.yellow,
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 5.0),
              child: Column (
                children: <Widget>[
                  underlinedText("Vault"),
                  Column (
                    children: <Widget>[
                      SizedBox(
                        height: 600,
                        child: ListView (
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: vaultCard(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: vaultCard(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: vaultCard(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: vaultCard(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: vaultCard(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: vaultCard(),
                            ),
                          ],
                        ),
                      ),
                    ],
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