import 'package:flutter/material.dart';

class PasswordGenerator extends StatefulWidget {

	@override
	_PasswordGeneratorState createState() => _PasswordGeneratorState();
}


class _PasswordGeneratorState extends State<PasswordGenerator> {

	// culori folosite
	Color my_grey = Colors.grey[300];
	Color light_blue = Colors.lightBlueAccent[100];
	Color theme_color = Colors.blue;
	Color white = Colors.white;

	// constante
	final double maxWidth = 600;

	// switchurile de optiuni speciale
	bool switch_AZ = false;
	bool switch_az = false;
	bool switch_09 = false;
	bool switch_others = false;

	// data field = curtom text form field
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

	// widget pentru o optiune speciala de generare a prolei
	Widget Option(String title, bool boolVal) {

		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: <Widget>[
				Text(title),
				Transform.scale(
					scale: 0.8,
				  child: Switch(
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
				),
			],
		);
	}

	// cele  4 optiuni speciale de generare a parolei
	Widget Options() {

		return Column(
			children: <Widget>[

				Row(
					children: <Widget>[
						Expanded(
							flex: 1,
							child: Option('A-Z', switch_AZ),
						),

						Expanded(
							flex: 1,
							child: Option('0-9', switch_09),
						),
					],
				),

				Row(
					children: <Widget>[
						Expanded(
							flex: 1,
							child: Option('a-z', switch_az),
						),

						Expanded(
							flex: 1,
							child: Option('!@#\$%^&*', switch_others),
						),
					],
				),
			],
		);
	}



	Widget build(BuildContext context) {

		return Column (
			mainAxisAlignment: MainAxisAlignment.start,
			crossAxisAlignment: CrossAxisAlignment.start,
			children: <Widget>[

				// title

				Padding(
				  padding: const EdgeInsets.all(8.0),
				  child: Text('Password Generator',  textScaleFactor: 1.7, style: TextStyle(fontWeight: FontWeight.bold),),
				),


				// linie de despartire
				Padding(
				  padding: const EdgeInsets.all(8.0),
				  child: Divider(color: my_grey, height: 2, thickness: 5, ),
				),

				// afisare parola generata
				Padding(
				  padding: const EdgeInsets.all(8.0),
				  child: SizedBox(
					  width: double.infinity,
				    child: ButtonTheme(
				    	height: 40.0,
				    	child: FlatButton(
				    		child: Text('hwjfuli3484pf', textAlign: TextAlign.center, style: TextStyle( fontSize: 20),),
				    		color: my_grey,
				    		onPressed: () {},
				    	)

				    ),
				  ),
				),

				// butoane REGENERARE + COPY
				Row(
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: <Widget>[

						// REGENERATE
						Expanded(
							flex: 1,
						    child: Padding(
						      padding: const EdgeInsets.only(left: 40, right: 40),
						      child: RaisedButton(
						          color: theme_color,
						          child: Text('REGENERATE', style: TextStyle(fontWeight: FontWeight.bold, color: white),),
						          onPressed: () {},
						      ),
						    ),
						),

						// COPY
						Expanded(
							flex: 1,
						  child: Padding(
							  padding: const EdgeInsets.only(left: 40, right: 40),
						    child: FlatButton(
						    	child: Text('COPY', style: TextStyle(fontWeight: FontWeight.bold, color: theme_color),),
						    	onPressed: () {},
						    ),
						  ),
						),
					],
				),

				// MINIMUM SPECIAL SI MINIMUM NUMBERS
				Row(
					children: <Widget>[
						
						// MINIMUM numbers
						Expanded(
							flex: 1,
							child: Padding(
							  padding: const EdgeInsets.all(8.0),
							  child: DataField('Minimum numbers'),
							)
						),
						
						// MINIMUM specials
						Expanded(
							flex: 1,
							child: Padding(
							  padding: const EdgeInsets.all(8.0),
							  child: DataField('Minimum special'),
							)
						),
					],
				),

				Row(
					children: <Widget>[

						// length field
						Expanded(
							flex: 1,
						  child: Padding(
						    padding: const EdgeInsets.all(8.0),
						    child: DataField('Length'),
						  ),
						),

						// special options field
						Expanded(
							flex: 1,
						  child: Padding(
						    padding: const EdgeInsets.only(
							    left: 16,
							    top: 8,
							    right: 4
						    ),
						    child: Options(),
						  ),
						),
					],
				),



			],
		);

	}
}