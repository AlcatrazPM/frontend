import 'package:alkatrazpm/src/accounts/service/AccountsService.dart';
import 'package:alkatrazpm/src/accounts/service/favicon/FavIconService.dart';
import 'package:alkatrazpm/src/dependencies/Dependencies.dart';
import 'package:alkatrazpm/src/password_gen/service/PasswordGen.dart';
import 'package:alkatrazpm/src/ui_utils/Loading.dart';
import 'package:alkatrazpm/src/ui_utils/SnackBarUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:alkatrazpm/src/accounts/model/Account.dart';
import 'package:alkatrazpm/src/accounts/model/AccountsFilter.dart';

import 'Auxiliars.dart';

import 'dart:io';

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

  Future<List<Account>> currentAccounts;

  LoadingController loadingController = LoadingController();

  @override
  void initState() {
    myFilter = new AccountsFilter(onlyFavorites: false, toSearch: '');
    listAccount = List();
    listaAfisata = filter(listAccount, myFilter);

    //Pop up stuff
    _websiteController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _favoriteController = false;

    //you need this empty account in order to know if you are creating a new account
    //or if you are editing an existing one.
    _account = new Account();

    currentAccounts = deps.get<AccountsService>().getAccounts();
    //End of pop up stuff
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: boxWidth,
              height: boxHeight,
              decoration: BoxDecoration(
                  // border: Border.all(),
                  ),
              child: Row(
                children: <Widget>[
                  //First Column of the page.
                  Expanded(
                    flex: 1,
                    child: Container(
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
                    child: Container(
                      //color: Colors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // title
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0, top: 8.0),
                            child: getHeading('Vault', context),
                          ),
                          Divider(
                            height: 3.0,
                            thickness: 2.0,
                          ),
                          Container(
                            height: boxHeight - 100,
                            padding: EdgeInsets.only(top: 4.0),
                            child: FutureBuilder<List<Account>>(
                                future: currentAccounts,
                                builder: (ctx, snapshot) {
                                  print(snapshot.data);
                                  if (snapshot.hasData) {
                                    listAccount =
                                        filter(snapshot.data, myFilter);
                                    listaAfisata = listAccount;
                                    return getListView();
                                  }
                                  return Center(
                                      child: CircularProgressIndicator());
                                }),
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
    var _account = listaAfisata[index];
    return ListTile(
      onTap: () {
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
      leading: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 30, maxHeight: 30),
          child: Image.memory(
            _account.iconBytes,
            scale: 0.5,
          )),
      subtitle: Text(listaAfisata[index].username),
      trailing: FlatButton(
        child: listaAfisata[index].isFavorite
            ? Icon(Icons.favorite)
            : Icon(Icons.favorite_border),
        onPressed: () {
          changeFavorite(listaAfisata[index]);
        },
      ),
    );
  }

  Widget getListView() {
    //var listItems = getListElements();

    var listView = ListView.separated(
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
            child: Row(
              children: <Widget>[
                Icon(Icons.add),
                Text("Add Item"),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
              side: BorderSide(
                color: Colors.blueGrey,
              ),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
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
        fontSize: 24,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget ToolsPrompt() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 60.0, right: 20.0),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(width: 2, color: Colors.blue),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: Auxiliars.leftP,
                    top: Auxiliars.topP,
                    bottom: Auxiliars.bottomP,
                  ),
                  child: Text(
                    "FILTERS",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.only(
                  left: Auxiliars.leftP, right: Auxiliars.leftP),
              child: Divider(
                height: 3,
                thickness: 3,
              ),
            ),

            //Here is the SEARCH BAR
            Container(
              padding: EdgeInsets.only(
                  top: 10.0,
                  left: Auxiliars.leftP / 2,
                  right: Auxiliars.leftP / 2),
              child: searchBar(),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 0.5, bottom: 0.0),
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Icon(
                        myFilter.onlyFavorites
                            ? Icons.border_clear
                            : Icons.border_all,
                        color:
                            myFilter.onlyFavorites ? Colors.black : Colors.blue,
                      ),
                    ),
                    Text(
                      "All items",
                      style: TextStyle(
                        color:
                            myFilter.onlyFavorites ? Colors.black : Colors.blue,
                      ),
                    ),
                  ],
                ),
                // color: Colors.blue,
                onPressed: () {
                  myFilter.onlyFavorites = false;
                  listaAfisata = filter(listAccount, myFilter);
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, right: 0.5),
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //color: Colors.red,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Icon(
                        myFilter.onlyFavorites ? Icons.star : Icons.star_border,
                        color:
                            myFilter.onlyFavorites ? Colors.blue : Colors.black,
                      ),
                    ),
                    Text(
                      "Favorites",
                      style: TextStyle(
                        color:
                            myFilter.onlyFavorites ? Colors.blue : Colors.black,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  myFilter.onlyFavorites = true;
                  listAccount = filter(listAccount, myFilter);
                  setState(() {});
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
        child: TextField(
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 15.0,
          ),
          decoration: InputDecoration(
              hintText: "Search...",
              contentPadding: EdgeInsets.all(10.0),
              filled: true,
              fillColor: Colors.white70,
              suffixIcon: Icon(Icons.search),
              //border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              )),
          onChanged: (String aux) {
            setState(() {
              myFilter.toSearch = aux;
              listaAfisata = filter(listAccount, myFilter);
            });
          },
          onSubmitted: (String aux) {},
        ),
      ),
    );
  }

  // data field = custom text form field
  //Data field for POP UP---------------------------------------
  //-------------------

  Widget DataField(
      String title, Account account, TextEditingController dataController) {
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
      style: TextStyle(
        fontSize: 15.0,
      ),
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
        contentPadding: EdgeInsets.only(
          bottom: 10.0,
          left: 10.0,
        ),
      ),
      //
      inputFormatters: [
        new LengthLimitingTextInputFormatter(30),
      ],
      onChanged: (String input_user) {
        print(dataController.text);
      },
    );
  }

  //Creates the POP UP-----------------------------------------------
  //-----------------
  createAccountDetailsDialog(BuildContext context, Account account) {
    loadingController = LoadingController();
    //this way you know if you are adding account or editing.
    //if isCreating is true, then you are adding new account.
    bool isCreating = account.username == '' ? true : false;

    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: AlertDialog(
                  contentPadding: EdgeInsets.all(0.0),
                  //title: Text(account.password),
                  content: Container(
                    width: 400,
                    height: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // butonul de CANCEL
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 8.0, bottom: 8.0, right: 16.0),
                          child: SizedBox(
                            height: 25,
                            child: Row(
                              children: <Widget>[
                                Spacer(),

                                // buton de cancel
                                Container(
                                  padding: EdgeInsets.all(0.0),
                                  width: 25,
                                  child: FlatButton(
                                    padding: EdgeInsets.all(0.0),
                                    color: Colors.white,
                                    hoverColor: Colors.yellow,
                                    splashColor: Colors.red,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // title
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: isCreating == true
                                  ? Text(
                                      'Add Account',
                                      textScaleFactor: 1.5,
                                    )
                                  : Text('Edit Account', textScaleFactor: 1.5),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.all(0.0),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: account.isFavorite
                                    ? Icon(Icons.favorite)
                                    : Icon(Icons.favorite_border),
                              ),
                            ),
                          ],
                        ),

                        // departitor
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.grey[300],
                            height: 2,
                            thickness: 3,
                          ),
                        ),

                        // webpage
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                          child: Text('Website'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 8.0, top: 8.0, bottom: 8.0),
                          child: SizedBox(
                              width: 300,
                              height: 35,
                              child: DataField(
                                  'Website', account, _websiteController)),
                        ),

                        // username
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                          child: Text('Username'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 8.0, top: 8.0, bottom: 8.0),
                          child: SizedBox(
                              width: 300,
                              height: 35,
                              child: DataField(
                                  'Username', account, _usernameController)),
                        ),

                        // password
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 8.0, top: 8.0, bottom: 8.0),
                              child: SizedBox(
                                  width: 300,
                                  height: 35,
                                  child: DataField(
                                      'Password', account, _passwordController)),
                            ),
                            IconButton(
                              icon: Icon(Icons.refresh),
                              onPressed: () {
                                print("gen");
                                genPassword();
                              },
                            )
                          ],
                        ),

                        Spacer(),

                        Row(
                          children: <Widget>[
                            // buton de save
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, bottom: 8.0),
                              child: Loading(
                                controller: loadingController,
                                child: RaisedButton(
                                  color: theme_color,
                                  splashColor: Colors.yellow,
                                  child: Text(
                                    'SAVE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (isCreating == false) {
                                        onChangesSaved(account);
                                      } else {
                                        onAccountCreation();
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),

                            Spacer(),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlatButton(
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
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

  void genPassword() async {
    _passwordController.text = await deps.get<PasswordGen>().generatePassword();
    print(_passwordController.text);
    setState(() {});
  }

  //Ready for Madalin---------------------------------------------------
  List<Account> filter(List<Account> myList, AccountsFilter myFilter) {
    return deps.get<AccountsService>().filter(myList, myFilter);
  }

  void changeFavorite(Account account) async {
    safeNetworkAction(() async {
      account.isFavorite = !account.isFavorite;
      await deps.get<AccountsService>().modifyAccount(account);
      setState(() {});
    }, pop: false);
  }

  //Called when Delete is pressed.
  void onDelete(Account account) async {
    safeNetworkAction(() async {
      await deps.get<AccountsService>().deleteAccount(account);
      (await currentAccounts).removeWhere((element) => element.id == account.id);
      loadingController.setDone();
      SnackBarUtils.showConfirmation(context, "Account deleted");
    });
  }

  void onChangesSaved(Account account) async {
    account.website = _websiteController.text;
    account.username = _usernameController.text;
    account.password = _passwordController.text;

    safeNetworkAction(() async {
      await deps.get<AccountsService>().modifyAccount(account);
      SnackBarUtils.showConfirmation(context, "Account changed");
    });
  }

  Future<void> onAccountCreation() async {
    safeNetworkAction(() async {
      Account account = Account(
          website: _websiteController.text,
          password: _passwordController.text,
          username: _usernameController.text);
      account = await deps.get<AccountsService>().addAccount(account);
      account.iconBytes =
          await deps.get<FavIconService>().getFavIcon(account.website);
      (await currentAccounts).add(account);
      setState(() {});
      SnackBarUtils.showConfirmation(context, "Account added");
    });
  }

  void safeNetworkAction(Future<void> action(), {bool pop = true}) async {
    try {
      loadingController.setLoading();
      await action.call();
      loadingController.setDone();
      setState(() {});
      if (pop) Navigator.pop(context);
    } catch (e) {
      print(e);
      loadingController.setDone();
      SnackBarUtils.showError(context, "something went wrong");
    }
  }
}
