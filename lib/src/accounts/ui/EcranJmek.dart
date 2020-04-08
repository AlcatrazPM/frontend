import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EcranJmek extends StatefulWidget {


  @override
  _EcranJmekState createState() => _EcranJmekState();
}

class _EcranJmekState extends State<EcranJmek> {
  bool isHeart = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          isHeart? Icon(Icons.favorite) : Container()
          ,
          RaisedButton(
            onPressed: (){
              setState(() {
                isHeart = !isHeart;
              });
            },
            child: Text("sdjndfjkdvf"),
          )
        ],
      ),
    );
  }
}
