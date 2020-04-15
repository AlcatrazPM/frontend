import 'package:flutter/material.dart';

class Account{
	String password;
	String username;
	String website;
	bool isFavorite;
	Account(this.website, this.username, this.password, this.isFavorite);
}