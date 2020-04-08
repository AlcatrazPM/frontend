import 'package:flutter/material.dart';


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
				//autofocus: true,
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

	// luat de la mihai
	Widget settingsButton(String text) {
		return Row (
			children: <Widget>[
				FlatButton(
					onPressed: (){},
					child: Row (
						children: <Widget>[
							Icon(Icons.favorite, color: my_grey,),
							Text(text),
						],
					),
				),
			],
		);
	}


	// for the additional options on the left
	Widget customCard() {
		return Container (
			width: 200.0,
			height: 250.0,
			margin: EdgeInsets.all(20),

			decoration: BoxDecoration (
				//color: Colors.purpleAccent,
				borderRadius: new BorderRadius.all(Radius.circular(10.0)),
				border: Border.all(color: Colors.grey),
			),

			child: Column(
				children: <Widget>[
					Padding(
						padding: const EdgeInsets.all(12.0),
						child: Text('Tools'),
					),
					Divider(height: 3, thickness: 2,),

					//Here the buttons start
					settingsButton('My Account'),
					settingsButton('Options'),
				],
			),
		);
	}






	@override
	Widget build(BuildContext context) {

		return Scaffold(

			body: Container(
					width: MediaQuery.of(context).size.width,
					child: Row(
					  children: <Widget>[

						  // coloana goala
						  Expanded(
							  flex: 15,
							  child: Column(),
						  ),

						  // cutie cu setari
						  Expanded(
							  flex: 20,
							  child: Column(
								  children: <Widget>[
									  customCard(),
								  ],
							  ),
						  ),

						  // coloana principala
					    Expanded(
							flex: 45,
					      child: Column(

					      	mainAxisAlignment: MainAxisAlignment.start,
					      	crossAxisAlignment: CrossAxisAlignment.start,
					      	children : <Widget> [

					      		// title
					      		SizedBox(height: 10,),
					      		Text('Options', textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold),),
					      		SizedBox(height: 10,),

					      		// linie de despartire
					      		Divider(color: my_grey, height: 2, thickness: 4,),
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
					      		SizedBox(height: 20,),
					      		Text('Encryption Key Settings',  textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold),),
					      		SizedBox(height: 10,),

					      		// linie de despartire
					      		Divider(color: my_grey, height: 2, thickness: 4,),
					      		SizedBox(height: 10,),

					      		// campuri de DATA
					      		Row(
					      			mainAxisAlignment: MainAxisAlignment.spaceBetween,
					      			children: <Widget>[

					      				Expanded(
					      					flex: 45,
					      					child: DataField('KDF Iterations'),
					      				),
					      				Expanded(
											flex: 10,
											child: Column(),
										),
					      				Expanded(
					      					flex: 45,
					      					child: CustomDropDownKdfAlgo(),
					      				),
					      			],
					      		),
					      		SizedBox(height: 10,),

					      		Row(
					      			mainAxisAlignment: MainAxisAlignment.spaceBetween,
					      			children: <Widget>[

					      				Expanded(
					      					flex: 45,
					      					child: DataField('Master Password'),
					      				),
										Expanded(
											flex: 55,
											child: Column(),
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
					      ),
					    ),

						  // coloana goala
						  Expanded(
							  flex: 15,
							  child: Column(),
						  ),
					  ],
					)
				),

		);
	}
}