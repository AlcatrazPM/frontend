import 'dart:convert';

import 'package:alkatrazpm/src/accounts/model/Account.dart';
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 1),
            Text("Alcatraz"),
            Spacer(flex: 2)
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
                        if (snapshot.hasData) {
                          var accounts = snapshot.data;

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
                    ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 60, maxHeight: 60),
                        child: Image.memory(
                          account.iconBytes,
                          scale: 0.7,
                        ))
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

  String minimumSizeTransform(String text) {
    if (text.length < 19) return text;
    return text.substring(0, 16) + "...";
  }

  Future<List<Account>> getAccounts() async {
    return deps.get<AccountsService>().getAccounts();
  }

  Future<void> refresh() async{
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

  void showDetails(BuildContext context, Account account) async{
    await Navigator.push(context,
        MaterialPageRoute(builder: (ctx) => AccountDetailsScreen(account)));
    setState(() {});
  }

  Future<void> removeAccount(Account account, int index) async {
    try{
      await deps.get<AccountsService>().deleteAccount(account);
      (await currentAccounts).removeWhere((a )=> a.id == account.id);
      SnackBarUtils.showConfirmation(context, "Account removed");
    }catch(e){
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
