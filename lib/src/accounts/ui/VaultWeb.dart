import 'dart:math';

import 'package:alkatrazpm/src/ui_utils/UIUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VaultWeb extends StatefulWidget {
  @override
  _VaultWebState createState() => _VaultWebState();
}

class _VaultWebState extends State<VaultWeb> {
  var max_edit_width = 250.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    max_edit_width = UiUtils.adaptableWidth(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        UiUtils.showDetailsSmall(context) ? Container() : Spacer(),
        MediaQuery.of(context).size.width < 700 ? Container() :
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Filters",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(height: 3, width: 200, color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 200),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "search",
                            helperText: "",
                            suffixIcon: Icon(Icons.search)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.favorite),
                        ),
                        Text("All items")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.favorite),
                        ),
                        Text("Favorites ")
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Chip(
                        label: Text("social"),
                      ),
                      Chip(
                        label: Text("shopping"),
                      ),
                    ],
                  ),
                  Chip(
                    label: Text("gaming"),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: max(UiUtils.adaptableWidth(context), 400),
          child: ListView.builder(
            itemBuilder: (context, i) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.pie_chart,
                        color: Colors.blue,
                        size: 150,
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "www.website.com",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text("username_jmek_2006", style: TextStyle(fontSize: 16),)
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: 20,
          ),
        ),
        MediaQuery.of(context).size.width < 700? Container() : Spacer()
      ],
    );
  }
}
