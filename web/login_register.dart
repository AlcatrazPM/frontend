import 'package:flutter/material.dart';
import 'tabs.dart';

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
	Widget EnterAccountButton(String text, BuildContext context) {

		return RaisedButton(
			color: Colors.blueAccent,
			child: Text(text, style: TextStyle(fontWeight: FontWeight.bold,
				color: Colors.white),),
			onPressed: () {
				// logica pentru apsaarea butonului de "Login"
				Navigator.push(context, MaterialPageRoute(builder: (context) => CustomTabBar()));
			},
		);
	}
//hootule
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
						EnterAccountButton('Login', context),

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
	Widget EnterAccountButton(String text, BuildContext context) {

		return RaisedButton(
			color: Colors.blueAccent,
			child: Text(text, style: TextStyle(fontWeight: FontWeight.bold,
				color: Colors.white),),
			onPressed: () {
				// logica pentru apsarea butonului de "Register"
				Navigator.push(context, MaterialPageRoute(builder: (context) => CustomTabBar()));
			},
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
						EnterAccountButton('Register', context),

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
