import 'package:flutter/material.dart';

import 'betterAccountSettings.dart';
import 'options.dart';
import 'password_generator.dart';
import 'vault.dart';



// tabs
class CustomTabBar extends StatelessWidget {

	Color theme_color = Colors.blue;

	// creates a raised button with the text "text"
	Widget ExitAccountButton(BuildContext context) {

		return ButtonTheme(

		        	child: RaisedButton(
		      		color: Colors.white,
		      		child: Text('Log out', style: TextStyle(fontWeight: FontWeight.bold,
		      			color: theme_color),),
		      		onPressed: () {
		      			Navigator.pop(context);
		      		},
		      	  ),
		);
	}

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			home: DefaultTabController(
				length: 4,
				initialIndex: 0,
				child: Scaffold(
					appBar: AppBar(
						automaticallyImplyLeading: false,
						bottom: PreferredSize(
						  child: Row(
						    children: <Widget>[
						    	// column with logo icon
						    	Expanded(
									flex: 1,
									child: Column(
										children: <Widget>[
											Icon(Icons.pets, color: Colors.white,)
										],
									)),

						      	// column with tabs
						      	Expanded(
										flex: 3,
										child: TabBar(
										tabs: [
											Text('Vault',textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold),),
											Text('Account Settings',textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold),),
											Text('Password Generator', textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold),),
											Text('Options',textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold),),
										],
									),
						      	),

								// column with log out button
								Expanded(
									flex: 2,
									child: Column(
										children: <Widget>[
											ExitAccountButton(context)
										],
									)),
						    ],
						  ),
						),
					),

					body: TabBarView(
						children: [
							Tab(child: Vault(),),
							Tab(child: BetterAccountSettings(),),
							Tab(child: PasswordGenerator(),),
							Tab(child: Options(),),


						],
					),

				),
			),


		);
	}
}