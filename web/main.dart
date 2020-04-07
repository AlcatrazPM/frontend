import 'package:flutter/material.dart';
import 'login_register.dart';
import 'tabs.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'AlcatrazPM',
			theme: ThemeData(
				primarySwatch: Colors.blue,
			),

			home: LogInPage(),
		);
	}
}










