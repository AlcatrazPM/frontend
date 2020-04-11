import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Account.dart';
import 'AccountsFilter.dart';

class BetterVault extends StatefulWidget {

  @override
  _BetterVaultState createState() => _BetterVaultState();
}

class _BetterVaultState extends State<BetterVault> {
  final boxWidth = 1000.0;
  final boxHeight = 800.0;

  //myFilter contains the string "toSearch", initially will be empty
  //And onlyFavorites, initially will be false.
  AccountsFilter myFilter;

  //In listAccount tinem toate elementele.
  List<Account> listAccount;
  //In listaAfisata tinem elementele filtrate.
  List<Account> listaAfisata;

  //Pop up stuff---------------------------
  TextEditingController _websiteController;
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  bool _favoriteController;
  Color theme_color = Colors.blue;

  //the only purpose of this empty account is to be added in function call when pressing "Add Item"
  Account _account;
  //End of pop up stuff-------------------

  @override
  void initState() {

    myFilter = new AccountsFilter(onlyFavorites: false, toSearch: '');
    listAccount = getListFromBackEnd();
    listaAfisata = filter(listAccount, myFilter);

    //Pop up stuff
    _websiteController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _favoriteController = false;

    //you need this empty account in order to know if you are creating a new account
    //or if you are editing an existing one.
    _account = new Account('', '', '', false);
    //End of pop up stuff
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center (
      child: SingleChildScrollView (
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView (
          scrollDirection: Axis.horizontal,
          child: Padding (
            padding: const EdgeInsets.all(8.0),
            child: Container (
              width: boxWidth,
              height: boxHeight,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Row(
                children: <Widget>[
                  //First Column of the page.
                  Expanded(
                    flex: 1,
                    child: Container (
                      //color: Colors.red,
                      child: Column(
                        children: <Widget>[
                          ToolsPrompt(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container (
                      //color: Colors.blue,
                      child: Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 50.0, top: 50.0),
                            child: getHeading("VAULT", context),
                          ),
                          Divider(height: 3.0, thickness: 2.0,),
                          Container (
                            height: boxHeight - 100,
                            padding: EdgeInsets.only(top: 4.0),
                            child: getListView(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }

  Widget getListTile(int index) {
    return ListTile (
      onTap: (){
        Account aux = listaAfisata[index];
        setState(() {
          createAccountDetailsDialog(context, aux);
        });
      },
      title: Text(
        listaAfisata[index].website,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      leading: Icon(Icons.web),
      subtitle: Text(listaAfisata[index].username),
      trailing: FlatButton (
        child: listaAfisata[index].isFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
        onPressed: (){
          setState(() {
            listaAfisata[index].isFavorite = !listaAfisata[index].isFavorite;
            listaAfisata = filter(listAccount, myFilter);
          });
        },
      ),
    );
  }

  Widget getListView() {
    //var listItems = getListElements();

    var listView = ListView.separated (

      itemCount: listAccount.length,

      separatorBuilder: (context, index) => Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Spacer(),
        ],
      ),

      itemBuilder: (context, index) {
        return Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: getListTile(index),
            ),
            Spacer(),
          ],
        );
      },
    );

    return listView;
  }

  Widget getHeading(String tit, BuildContext context) {
   return Row(
      children: <Widget>[
        getTitle(tit),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, bottom: 8.0),
          child: FlatButton(
            clipBehavior: Clip.antiAlias,
            child: Row (
              children: <Widget>[
                Icon(Icons.add),
                Text("Add Item"),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
              side: BorderSide (
                color: Colors.blueGrey,
              ),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: (){
              setState(() {
                createAccountDetailsDialog(context, _account);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget getTitle(String tit) {
    return Text(
      tit,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.8,
    ),
    );
  }

  Widget ToolsPrompt() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 60.0, right: 20.0),
      child: Container (
        height: 300,
        decoration: BoxDecoration (
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),

          border: Border.all(
              width: 2,
              color: Colors.blue),
        ),
        child: Column (
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 8),
                  child: Text("FILTERS",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 3, thickness: 3,),

            //Here is the SEARCH BAR
            Container(
              padding: EdgeInsets.only(top: 3.0),
              child: searchBar(),
            ),

            Padding(
              padding: const EdgeInsets.only( top: 8.0, right: 0.5, bottom: 0.0),
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Row (
                  children: <Widget>[
                    Icon( myFilter.onlyFavorites ?  Icons.border_clear : Icons.border_all),
                    Text("All items"),
                  ],
                ),
               // color: Colors.blue,
                onPressed: (){
                  setState(() {
                    myFilter.onlyFavorites = false;
                    listaAfisata = filter(listAccount, myFilter);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, right: 0.5),
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //color: Colors.red,
                child: Row (
                  children: <Widget>[
                    Icon(myFilter.onlyFavorites ? Icons.star : Icons.star_border),
                    Text("Favorites"),
                  ],
                ),
                onPressed: (){
                  setState(() {
                    myFilter.onlyFavorites = true;
                    listaAfisata = filter(listAccount, myFilter);
                  });
                },
              ),
            ),

          ],
        ),

      ),
    );
  }

  //This is my searchBar for the FILTER
  //-------------

  Widget searchBar() {
    return SizedBox(
      height: 55,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField (
          textAlign: TextAlign.left,
          style: TextStyle (
            fontSize: 15.0,
          ),
          decoration: InputDecoration (
              hintText: "Search...",
              contentPadding: EdgeInsets.all(10.0),
              filled: true,
              fillColor: Colors.white70,
              suffixIcon: Icon(Icons.search),
              //border: InputBorder.none,
              focusedBorder: OutlineInputBorder (
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
              enabledBorder: OutlineInputBorder (
                borderSide: BorderSide(color: Colors.grey),
              )
          ),
          onChanged: (String aux){
            setState(() {
              myFilter.toSearch = aux;
              listaAfisata = filter(listAccount, myFilter);
            });
          },
          onSubmitted: (String aux) {
          },
        ),
      ),
    );
  }

  // data field = custom text form field
  //Data field for POP UP---------------------------------------
  //-------------------

  Widget DataField(String title, Account account, TextEditingController dataController) {

    switch (title) {
      case 'Website':
        dataController.text = account.website;
        break;
      case 'Username':
        dataController.text = account.username;
        break;
      case 'Password':
        dataController.text = account.password;
        break;
    }

    return TextFormField(
      controller: dataController,
      cursorColor: Colors.amber,
      style: TextStyle( fontSize: 15.0,),
      decoration: InputDecoration(
        //labelText: title,
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
        contentPadding: EdgeInsets.only(bottom: 10.0, left: 10.0,),
      ),
      inputFormatters: [new LengthLimitingTextInputFormatter(30),],
      onChanged: (String input_user) {
        print(dataController.text);
      },
    );
  }


  //Creates the POP UP-----------------------------------------------
  //-----------------
  createAccountDetailsDialog(BuildContext context, Account account) {
    //this way you know if you are adding account or editing.
    //if isCreating is true, then you are adding new account.
    bool isCreating = account.username == '' ? true : false;

    return showDialog(context: context, builder: (context) {

      return Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: AlertDialog(
              //title: Text(account.password),
              content: Container(
                width: 400,
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    // title
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                          child: isCreating == true ? Text('Add Account', textScaleFactor: 1.5,) : Text('Edit Account',  textScaleFactor: 1.5),
                        ),

                        Spacer(),

                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: account.isFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                        ),
                      ],
                    ),
                    // departitor
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(color: Colors.grey[300], height: 2, thickness: 3, ),
                    ),

                    // webpage
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: Text('Website'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: 300,
                          height: 35,
                          child: DataField('Website', account, _websiteController)),
                    ),

                    // username
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: Text('Username'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: 300,
                          height: 35,
                          child: DataField('Username', account, _usernameController)),
                    ),

                    // password
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: Text('Password'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: 300,
                          height: 35,
                          child: DataField('Password', account, _passwordController)),
                    ),

                    Spacer(),

                    Row(
                      children: <Widget>[
                        // buton de save
                        RaisedButton(
                          color: theme_color,
                          splashColor: Colors.yellow,
                          child: Text('SAVE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                          onPressed: () {
                            setState(() {
                              if (isCreating == false) {
                                onChangesSaved(account);
                              } else {
                                onAccountCreation();
                              }
                              Navigator.pop(context);
                            });
                          },
                        ),

                        Spacer(),

                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: FlatButton(
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.delete_forever, color: Colors.red,),
                                Text('Delete', style: TextStyle(color: Colors.red),),
                              ],
                            ),
                            onPressed: () {
                              // trimit accountul mai departe care trebuie sters
                              setState(() {
                                onDelete(account);
                              });
                            },
                          ),
                        ),

                        // buton de cancel
                        RaisedButton(
                          color: theme_color,
                          splashColor: Colors.yellow,
                          child: Text('CANCEL', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                        ),

                      ],
                    ),

                    // buton de cancel

                    //
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  //Ready for Madalin---------------------------------------------------
  List<Account> filter (List<Account> myList, AccountsFilter myFilter) {
    return myList;
  }

  List<Account> getListFromBackEnd() {
    List<Account> aux = new List<Account>();
    aux.add(Account("youtube.com", "Jonuletzul", "1234", false));
    aux.add(Account("Filelist", "LinoGolden", "panamera", false));
    aux.add(Account("Xbox", "Vadim", "Regele", false));
    return aux;
  }

  //Called when Delete is pressed.
  void onDelete(Account account) {

  }

  void onChangesSaved(Account account) {
    // in _websiteController, _passwordController, _usernameController
    // you have the new values.
    //They have to be added to "account"
    account.website = _websiteController.text;
    account.username = _usernameController.text;
    account.password = _passwordController.text;
  }

  void onAccountCreation() {
    // in _websiteController, _passwordController, _usernameController
    // you have the values for the new account
    // you have to initialize a new Account object and add it to list.
    print("Creating account.\n");
  }
}