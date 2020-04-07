import 'package:flutter/material.dart';

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

			//home: LogInPage(),
			//home: PasswordGenerator(),
			home: Options(),
		);
	}
}


class LogInPage extends StatelessWidget {

	// titlu, obscuritatea textului introdus, incoul corespunzator
	Widget CustomDataField(String text, bool obsc, IconData icon) {

		return TextFormField(
			autofocus: true,
			cursorColor: Colors.amber,
			style: TextStyle(height: 2.0),
			obscureText: obsc,  // hides the password
			decoration: InputDecoration(
				labelText: text,
				icon: Icon(icon),
			),
		);
	}

	// creates a raised button with the text "text"
	Widget EnterAccountButton(String text) {

		return RaisedButton(
			color: Colors.blueAccent,
			child: Text(text, style: TextStyle(fontWeight: FontWeight.bold,
												color: Colors.white),),
			onPressed: () => {},
		);
	}

	Widget ChangeMainPageButton(BuildContext context) {

		Widget flatBut = FlatButton(
			child: Text('Register',
						style: TextStyle(fontWeight: FontWeight.bold,
										color: Colors.blueAccent),
						),
			onPressed: () {
				Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));

			},
		);


		return flatBut;
	}


	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: AppBar(
				title: Center(
					child: Text('Login', textAlign: TextAlign.center,),)
			),

			body: Center(
				child: Column(

					mainAxisAlignment: MainAxisAlignment.center,

					children: <Widget> [
						// username and password
						Container(
							width: 300,
							child: Column(
								children : <Widget> [
									// username
									CustomDataField('Username', false, Icons.account_circle),
									// password
									CustomDataField('Password', true, Icons.security),
							]
							)
						),

						// Login button
						SizedBox(height: 30,),
						EnterAccountButton('Login'),

						// other option login/register
						//SizedBox(height: 30,),
						SizedBox(height: 50,),
						Text('Don\'t have an account?'),
						ChangeMainPageButton(context),

					]
				),

			),

			floatingActionButton: FloatingActionButton(
				child: Icon(Icons.favorite, color: Colors.yellowAccent,),
				onPressed: () => {},
			),
		);
	}
}






class RegisterPage extends StatelessWidget {

	String password = 'alex';

	// titlu, obscuritatea textului introdus, incoul corespunzator
	Widget CustomDataField(String text, bool obsc, IconData icon) {

		return TextFormField(
			autofocus: true,
			cursorColor: Colors.amber,
			style: TextStyle(height: 2.0),
			obscureText: obsc,  // hides the password
			decoration: InputDecoration(
				labelText: text,
				icon: Icon(icon),
			),
		);
	}

	// titlu, obscuritatea textului introdus, incoul corespunzator
	Widget CustomDataFieldValidation(String text, bool obsc, IconData icon) {

		return TextFormField(
			autofocus: true,
			cursorColor: Colors.amber,
			style: TextStyle(height: 2.0),
			obscureText: obsc,  // hides the password
			decoration: InputDecoration(
				labelText: text,
				icon: Icon(icon),
			),
			autovalidate: true,
			validator: (String confirmPass) {
				if (confirmPass != password)
					return 'Passwords do not match';
				return null;
			},
		);
	}

	// creates a raised button with the text "text"
	Widget EnterAccountButton(String text) {

		return RaisedButton(
			color: Colors.blueAccent,
			child: Text(text, style: TextStyle(fontWeight: FontWeight.bold,
				color: Colors.white),),
			onPressed: () => {},
		);
	}

	Widget ChangeMainPageButton(BuildContext context) {

		Widget flatBut = FlatButton(
			child: Text('Login',
				style: TextStyle(fontWeight: FontWeight.bold,
					color: Colors.blueAccent),
			),
			onPressed: () {
				Navigator.pop(context);
				},
		);


		return flatBut;
	}


	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: AppBar(
				title: Center(
					child: Text('Register', textAlign: TextAlign.center,),)
			),

			body: Center(
				child: Column(

					mainAxisAlignment: MainAxisAlignment.center,

					children: <Widget> [

						// username and password
						Container(
							width: 300,
							child: Column(
								children : <Widget> [
									// email
									CustomDataField('Email', false, Icons.mail),
									// username
									CustomDataField('Username', false, Icons.account_circle),
									// password
									CustomDataField('Password', true, Icons.security),
									// confirm password
									CustomDataFieldValidation('Confirm Password', true, Icons.check),
								]
							)
						),

						// Login button
						SizedBox(height: 30,),
						EnterAccountButton('Register'),

						// other option login/register
						//SizedBox(height: 30,),
						SizedBox(height: 50,),
						Text('Already have an account?'),
						ChangeMainPageButton(context),

					]
				),

			),

			floatingActionButton: FloatingActionButton(
				child: Icon(Icons.favorite, color: Colors.yellowAccent,),
				onPressed: () => {},
			),
		);
	}
}



class PasswordGenerator extends StatefulWidget {
  @override
  _PasswordGenerator createState() => _PasswordGenerator();
}


class _PasswordGenerator extends State<PasswordGenerator> {

	// culori folosite
	Color my_grey = Colors.grey[300];
	Color light_blue = Colors.lightBlueAccent[100];
	Color theme_color = Colors.blue;

	// latimea coloanei
	//double maxWidth = 800;
	double maxWidth;

	// pentru switchurile de optiuni
	bool switch_AZ = false;
	bool switch_az = false;
	bool switch_09 = false;
	bool switch_others = false;

	// data field
	Widget DataField(String title) {

		return TextFormField(
			autofocus: true,
			cursorColor: Colors.amber,
			style: TextStyle(height: 1.0),
			decoration: InputDecoration(
				labelText: title,
				border: OutlineInputBorder(borderSide: BorderSide(color: theme_color)),
			),
		);

	}

	// widget pentru optimile suplimentare de generare a parolei
	Widget Option(String title, bool boolVal) {

		return Row(

			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: <Widget>[
				Text(title),
				Switch(
					value: boolVal,
					activeColor: theme_color,
					onChanged: (bool value) {
						setState(() {
							switch (title) {
								case 'A-Z':
									switch_AZ = value;
									break;
								case 'a-z':
									switch_az = value;
									break;
								case '0-9':
									switch_09 = value;
									break;
								case '!@#\$%^&*':
									switch_others = value;
									break;
							}
						});
					},
				),
			],
		);
	}


	Widget Options() {
		return Column(

			children: <Widget>[
				Row(
					children: <Widget>[
						SizedBox(
							width: (maxWidth / 2) * 0.45,
							child: Option('A-Z', switch_AZ),
						),

						SizedBox(
							width: (maxWidth / 2) * 0.45,
							child: Option('0-9', switch_09),
						),
					],
				),

				Row(
					children: <Widget>[
						SizedBox(
							width: (maxWidth / 2) * 0.45,
							child: Option('a-z', switch_az),
						),

						SizedBox(
							width: (maxWidth / 2) * 0.45,
							child: Option('!@#\$%^&*', switch_others),
						),

					],
				),
			],
		);
	}




	@override
	Widget build(BuildContext context) {

		maxWidth = (MediaQuery.of(context).size.width / 2) * 0.5;

		return Scaffold(
			appBar: AppBar(
				title: Center(
					child: Text('ceva care va fi inclouit', textAlign: TextAlign.center,),)
			),

			body: Center(
				child:Container(
					width: maxWidth,
					child: Column(

						mainAxisAlignment: MainAxisAlignment.start,
						crossAxisAlignment: CrossAxisAlignment.start,
						children : <Widget> [

							// title
							SizedBox(height: 10,),
							Text('Password Generator', textScaleFactor: 2,),
							SizedBox(height: 10,),

							// linie de despartire
							Divider(color: my_grey, height: 2, thickness: 5,),
							SizedBox(height: 10,),

							// afisare parola generata
							ButtonTheme(
								minWidth: maxWidth,
								height: 40.0,
								child: FlatButton(
										child: Text('hwjfuli3484pf', textAlign: TextAlign.center, style: TextStyle( fontSize: 20),),
										color: my_grey,
										onPressed: () {},
								)

							),
							SizedBox(height: 10,),

							// buton "REGENERARE"
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceAround,
								children: <Widget>[
									ButtonTheme(
										minWidth: maxWidth * 2 / 5,
										child:
										RaisedButton(
											color: theme_color,
											child: Text('REGENERATE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
											onPressed: () => {},
										),
									),

									ButtonTheme(
										minWidth: maxWidth * 2 / 5,
										child:
										FlatButton(
											//color: theme_color,
											child: Text('COPY', style: TextStyle(fontWeight: FontWeight.bold, color: theme_color),),
											onPressed: () => {},
										),
									),
								],
							),
							SizedBox(height: 20,),

							// MINIMUM SPECIAL SI MINIMUM NUMBERS
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceAround,
							  	children: <Widget>[

									SizedBox(
										width: maxWidth * 0.45,
										child: DataField('Minimum numbers'),
									),
									SizedBox(
										width: maxWidth * 0.45,
										child: DataField('Minimum Special'),
									),
							  ],
							),
							SizedBox(height: 10,),


							Row(
								mainAxisAlignment: MainAxisAlignment.spaceAround,
								children: <Widget>[

									SizedBox(
										width: maxWidth * 0.45,
										child: DataField('Length'),
									),
									SizedBox(
										width: maxWidth * 0.45,
										child: Options(),
									),
								],
							),
						]
					)
				),
			),
		);
	}
}

class Options extends StatefulWidget {
  @override
  _Options createState() => _Options();

}

class _Options extends State<Options> {

	// culori folosite
	Color my_grey = Colors.grey[300];
	Color light_blue = Colors.lightBlueAccent[100];
	Color theme_color = Colors.blue;

	// latimea coloanei
	double maxWidth = 800;

	// valoarea pentru dropDownButton
	String dropDownValueLockDown = '1 minute';
	String dropDownValueKdfAlgo = 'Algo numero 1';

	// lista pentru lookdown dropdown
	var lockDown = ['1 minute', '10 minutes', '1 hour', 'Limitless'];
	// lista de algoritmi de criptare
	var kdfAlgos = ['Algo numero 1', 'Algo numero 2', 'Algo numero 3', 'Algo numero 4', 'Algo numero 5'];


	// data field
	Widget DataField(String title) {

		return TextFormField(
			autofocus: true,
			cursorColor: Colors.amber,
			style: TextStyle(height: 1.0),
			decoration: InputDecoration(
				labelText: title,
				border: OutlineInputBorder(borderSide: BorderSide(color: theme_color)),
			),
		);
	}

	// drop down list for "lock down"
	Widget CustomDropDownLockDown() {
		return SizedBox(
			width: 200,
			height: 100,
			child: DropdownButton<String>(

				value: dropDownValueLockDown,
				autofocus: true,
				icon: Icon(Icons.arrow_drop_down),
				onChanged: (String newValue) {
					setState(() {
						dropDownValueLockDown = newValue;
					});
				},
				items: lockDown.map<DropdownMenuItem<String>>((String value) {
					return DropdownMenuItem<String>(
						value: value,
						child: Text(value),
					);
				})
					.toList(),
		));
	}

	// drop down list for "lock down"
	Widget CustomDropDownKdfAlgo() {
		return SizedBox(
			width: 200,
			height: 100,
			child: DropdownButton<String>(

				value: dropDownValueKdfAlgo,
				autofocus: true,
				icon: Icon(Icons.arrow_drop_down),
				onChanged: (String newValue) {
					setState(() {
						dropDownValueKdfAlgo = newValue;
					});
				},
				items: kdfAlgos.map<DropdownMenuItem<String>>((String value) {
					return DropdownMenuItem<String>(
						value: value,
						child: Text(value),
					);
				})
					.toList(),
			));
	}





	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: AppBar(
				title: Center(
					child: Text('ceva care va fi inclouit', textAlign: TextAlign.center,),)
			),

			body: Center(
				child:Container(
					width: maxWidth,
					child: Column(

						mainAxisAlignment: MainAxisAlignment.start,
						crossAxisAlignment: CrossAxisAlignment.start,
						children : <Widget> [

							// title
							SizedBox(height: 10,),
							Text('Options', textScaleFactor: 2,),
							SizedBox(height: 10,),

							// linie de despartire
							Divider(color: my_grey, height: 2, thickness: 5,),
							SizedBox(height: 10,),

							// drop down locked
							Text('Lock Options', ),
							SizedBox(height: 10,),
							CustomDropDownLockDown(),

							// buton SAVE
							ButtonTheme(
								minWidth: 100,
								child:
								RaisedButton(
									color: theme_color,
									child: Text('SAVE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
									onPressed: () => {},
								),
							),

							// ENCRIPTION
							SizedBox(height: 100,),
							Text('Encryption Key Settings', textScaleFactor: 2,),
							SizedBox(height: 10,),

							// linie de despartire
							Divider(color: my_grey, height: 2, thickness: 5,),
							SizedBox(height: 10,),

							// campuri de DATA
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[

									SizedBox(
										width: maxWidth * 0.45,
										child: DataField('KDF Iterations'),
									),
									SizedBox(
										width: maxWidth * 0.45,
										child: CustomDropDownKdfAlgo(),
									),



								],
							),
							SizedBox(height: 10,),

							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[

									SizedBox(
										width: maxWidth * 0.45,
										child: DataField('Master Password'),
									),
								],
							),
							SizedBox(height: 10,),

							// buton SAVE
							ButtonTheme(
								minWidth: 100,
								child:
								RaisedButton(
									color: theme_color,
									child: Text('SAVE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
									onPressed: () => {},
								),
							),


						]
					)
				),
			),
		);
	}
}
