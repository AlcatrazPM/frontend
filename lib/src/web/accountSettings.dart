import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountSettings extends StatelessWidget {

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  Widget myForm(String first, String second) {
    return Form (
      child: Expanded(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10,),

            TextFormField (
              decoration: InputDecoration(
                labelText: first,
//              enabledBorder: OutlineInputBorder (
//              borderSide: BorderSide(color: Colors.purpleAccent, width: 5.0),
//              ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                ),
//
              ),
              cursorColor: Colors.yellow,
              cursorWidth: 4.0,
              onChanged: (String val){

              },
              onSaved: (String val){

              },
              validator: (String val){
                return null;
              },
              showCursor: true,
            ),

            SizedBox(height: 20,),

            TextFormField (
              decoration: InputDecoration(
                labelText: second,
//              enabledBorder: OutlineInputBorder (
//              borderSide: BorderSide(color: Colors.purpleAccent, width: 5.0),
//              ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                ),
//
              ),
              cursorColor: Colors.yellow,
              cursorWidth: 4.0,
              onChanged: (String val){

              },
              onSaved: (String val){

              },
              validator: (String val){
                return null;
              },
              showCursor: true,
            ),
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    child: const Text('Submit'),
                    color: Colors.green,
                    onPressed: () {},
                  ),
                ),
                Expanded(flex: 2, child: SizedBox()),
              ],
            ),
          ],
        ),
      ),

    );
  }

  Widget build(BuildContext context) {
    return Scaffold (
      body: Row (
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            //First empty column
            Expanded (
              child: Column(),
              flex: 1,
            ),
            //My Column with data
            Expanded (
              flex: 1,
              child: Container(
                //color: Colors.red,
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //One Row for Change E-mail
                    Expanded (
                      flex: 1,
                      child: Container(
                        //color: Colors.blue,
                        child: Row (
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Column (
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ////////////////////////////////////
                                  SizedBox(height: 20),
                                  Text(
                                    "Change E-mail",
                                    style: TextStyle(
                                      //fontFamily: ,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Divider(height: 2, thickness: 2,),
                                  //SizedBox(height: 4),
                                  myForm("E-mail", "Master Password"),
                                ],
                              ),
                            ),
                            //Second object which creates the spacing
                            Expanded(
                              flex: 1,
                              child: Column (
                                children: <Widget>[
                                  SizedBox(height: 39,),
                                  Divider(height: 10, thickness: 2,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Second Row for Change Master Password.
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column (
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              "Change Master Password",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Divider(height: 30, thickness: 2,),
                            Row (
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "First thing",
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row (
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "Second thing",
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),

                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "Third thing",
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: RaisedButton(
                                    child: const Text('Submit'),
                                    color: Colors.green,
                                    onPressed: () {},
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Third empty column
            Expanded(
              flex: 1,
              child: Column(),
            ),
          ],
        ),
    );
  }
}