/// models the filters that are applied when searching for accounts

class AccountsFilter {
  bool onlyFavorites;
  String toSearch;
  AccountsFilter({this.onlyFavorites = false, this.toSearch = ""});
}
