import 'dart:convert';

import 'package:alkatrazpm/src/accounts/model/Account.dart';
import 'package:alkatrazpm/src/accounts/model/AccountsFilter.dart';
import 'package:alkatrazpm/src/accounts/service/AccountsService.dart';
import 'package:alkatrazpm/src/accounts/service/favicon/FavIconService.dart';
import 'package:alkatrazpm/src/accounts/ui/AccountDetailsScreen.dart';
import 'package:alkatrazpm/src/accounts/ui/AddAcountDialog.dart';
import 'package:alkatrazpm/src/accounts/ui/Menu.dart';
import 'package:alkatrazpm/src/auth/model/User.dart';
import 'package:alkatrazpm/src/auth/service/AuthService.dart';
import 'package:alkatrazpm/src/dependencies/Dependencies.dart';
import 'package:alkatrazpm/src/ui_utils/AppPage.dart';
import 'package:alkatrazpm/src/ui_utils/SnackBarUtils.dart';
import 'package:alkatrazpm/src/ui_utils/UIUtils.dart';
import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//TODO NOW THIS SCREEN IS PRETTY INEFFICIENT, will optimize but need to talk
// with teammates about functionality
class AccountsListScreen extends StatefulWidget {
  @override
  _AccountsListScreenState createState() => _AccountsListScreenState();
}

class _AccountsListScreenState extends State<AccountsListScreen> {
  Future<List<Account>> currentAccounts;
  bool isSearchBarActive = false;
  AccountsFilter filter = AccountsFilter();

  @override
  void initState() {
    currentAccounts = getAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: kIsWeb ? null : Menu(),
      appBar: AppBar(
        title: isSearchBarActive
            ? Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: (){
                  filter.onlyFavorites = !filter.onlyFavorites;
                  setState(() {});
                },
                icon: Icon(filter.onlyFavorites ? Icons.favorite : Icons.favorite_border),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context)
                  .size.width*0.45),
              child: Theme(
                data: Theme.of(context).copyWith(primaryColor: Colors.blue,
                    brightness: Brightness.dark),
                child: TextField(
                  onChanged: (val){
                    filter.toSearch = val;
                    setState(() {});
                  },
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color:Colors.white60),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    hintText: "Search here",
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: IconButton(
                onPressed: (){
                  isSearchBarActive = false;
                  setState(() {});
                },
                icon: Icon(Icons.close),
              ),
            )
          ],
        )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(flex: 1),
                  Text("Alcatraz"),
                  Spacer(flex: 1),
                  IconButton(icon: Icon(Icons.search),
                  onPressed: (){
                    isSearchBarActive = true;
                    setState(() {});
                  },)
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddAccountDialog,
        child: Icon(Icons.add),
      ),
      body: AppPage(
        child: Center(
          child: Container(
            width: UiUtils.adaptableWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      return refresh();
                    },
                    child: FutureBuilder<List<Account>>(
                      future: currentAccounts,
                      builder: (context, snapshot) {
                        List<Account> accounts = List();
                        if (snapshot.hasError) {
                          return ListView.builder(
                            addAutomaticKeepAlives: true,
                            itemBuilder: (ctx, i) {
                              return Container(
                                child: Text("Something went "
                                    "wrong"),
                              );
                            },
                            itemCount: 1,
                          );
                        }
                        if (snapshot.hasData) {
                          accounts = filterAccounts(snapshot.data, filter);
                          currentAccounts = Future.value(List<Account>.from
                            (snapshot.data));
                          return ListView.builder(
                            addAutomaticKeepAlives: true,
                            itemBuilder: (ctx, i) {
                              return accountCard(ctx, accounts[i], i);
                            },
                            itemCount: accounts.length,
                          );
                        }
                        return Center(
                          child: Hero(
                              tag: "progress",
                              child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget accountCard(BuildContext context, Account account, int index) {
    return Dismissible(
      onDismissed: (dir) async {
        removeAccount(account, index);
      },
      key: UniqueKey(),
      background: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.red[300],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                  size: 30,
                ),
                Spacer(),
                Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                  size: 30,
                )
              ],
            ),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          showDetails(context, account);
        },
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(kIsWeb ? 8.0 : 16.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ConstrainedBox(
                        constraints:
                        BoxConstraints(maxWidth: 60, maxHeight: 60, minWidth:
                        60, minHeight: 60),
                        child: Image.memory(
                          account.iconBytes,
                          scale: 0.7,
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          //TODO update tags
                          tag: "websiteTag$index",
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              minimumSizeTransform(account.website),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hero(
                            tag: "usernameTag$index",
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(
                                minimumSizeTransform(account.username),
                                style: TextStyle(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(account.isFavorite ? Icons.favorite : Icons
                          .favorite_border, color: Colors.blue,),
                      onPressed: () {changeFavorite(account);},
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Icon(Icons.keyboard_arrow_down),
                      onPressed: () {
                        showDetails(context, account);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> changeFavorite(Account account) async{
    try{
      await deps.get<AccountsService>().changeFavorite(account);
      setState(() {});
    }catch(e){
      account.isFavorite = !account.isFavorite;
      SnackBarUtils.showError(context, "Couldn't change");
    }
  }
  List<Account> filterAccounts(List<Account> accounts, AccountsFilter filter){
    return deps.get<AccountsService>().filter(accounts, filter);
  }
  String minimumSizeTransform(String text) {
    if (text.length < 19) return text;
    return text.substring(0, 16) + "...";
  }

  Future<List<Account>> getAccounts() async {
    return deps.get<AccountsService>().getAccounts();
  }


  Future<void> refresh() async {
    currentAccounts = getAccounts();
    await currentAccounts;
    setState(() {});
    return Future.value();
  }

  void showAddAccountDialog() async {
    var res = await showDialog(context: context, child: AddAccountDialog());
    if (res != null && res is Account) {
      try {
        await deps.get<AccountsService>().addAccount(res);
        (await currentAccounts).add(res);
        setState(() {});
        SnackBarUtils.showConfirmation(context, "Account added");
      } catch (e) {
        SnackBarUtils.showError(context, e.toString());
      }
    }
  }

  void showDetails(BuildContext context, Account account) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (ctx) => AccountDetailsScreen(account)));
    setState(() {});
  }

  Future<void> removeAccount(Account account, int index) async {
    try {
      await deps.get<AccountsService>().deleteAccount(account);
      (await currentAccounts).removeWhere((a) => a.id == account.id);
      SnackBarUtils.showConfirmation(context, "Account removed");
    } catch (e) {
      SnackBarUtils.showError(context, e.toString());
      setState(() {});
    }
  }

  Future<void> changeFavoriteAccount(Account account) async {
    try {
      account.isFavorite = !account.isFavorite;
      await deps.get<AccountsService>().changeFavorite(account);
    } catch (e) {}
  }
}
