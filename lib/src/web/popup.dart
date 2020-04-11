import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ip_etapa2/Account.dart';

enum CriptoType {
	DaCuZaru,
	DaCuBanu,
	RandomOrg
}

class ExportVault extends StatefulWidget {

	@override
	_ExportVaultState createState() => _ExportVaultState();
}

class _ExportVaultState extends State<ExportVault> {
	double leftPadding = 32.0;
	Account _account;




	// -------------
	TextEditingController _websiteController;
	TextEditingController _usernameController;
	TextEditingController _passwordController;
	Color theme_color = Colors.blue;

	@override
	void initState() {
		_websiteController = TextEditingController();
		_usernameController = TextEditingController();
		_passwordController = TextEditingController();
		_account = new Account('', '', '', true);
		super.initState();
	}

	// data field = curtom text form field
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
			style: TextStyle(height: 1.0),
			decoration: InputDecoration(
				//labelText: title,
				border: OutlineInputBorder(borderSide: BorderSide(color: theme_color)),
			),
			inputFormatters: [new LengthLimitingTextInputFormatter(20),],
			onChanged: (String input_user) {
				print(dataController.text);
			},
		);
	}


	createAccountDetailsDialog(BuildContext context, Account account) {

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
					                  child: Text('Edit Item',  textScaleFactor: 1.5),
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
								      	  account.website = _websiteController.text;
								      	  account.username = _usernameController.text;
								      	  account.password = _passwordController.text;

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

	//--------------



	Widget build(BuildContext context) {
		return Column (
			mainAxisAlignment: MainAxisAlignment.start,
			crossAxisAlignment: CrossAxisAlignment.start,
			children: <Widget>[

				//Here starts the submit button
				RaisedButton (
					child: Text (
						"Export"
					),
					onPressed: (){

						//-------------
						// apre pop up ul
						createAccountDetailsDialog(context, _account);
						//-----------
						},

				),
			],
		);
	}
}