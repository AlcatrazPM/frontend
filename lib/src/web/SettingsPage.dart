
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Settings_MyAccount.dart';
import 'Settings_Options.dart';


class SettingsPage extends StatefulWidget {

	@override
	_SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

	final boxWidth = 1000.0;
	final boxHeight = 800.0;

	bool isMyAccountPage;

	@override
	void initState() {
		isMyAccountPage = false;
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return Center (
			child: SingleChildScrollView(
				scrollDirection: Axis.vertical,
				child: SingleChildScrollView(
					scrollDirection: Axis.horizontal,
					child: Padding (
						padding: EdgeInsets.all(8.0),
						child: Container (
							height: boxHeight,
							width:  boxWidth,
							decoration: BoxDecoration (
								border: Border.all(),
							),
							child: Row(
								children: <Widget>[
									Expanded (
										flex: 1,
										child: Container (
											//color: Colors.red,
											child: Column (
												children: <Widget>[
													ToolsPrompt(),
												],
											),
										),
									),
									Expanded (
										flex: 3,
										child: Container(
											//color: Colors.blue,
											child: Column (
												children: <Widget>[
													////////////////////////////////////////////////////////////////////////////@ALEXANDRAA, eu fac Options.
													isMyAccountPage ? MyAccount() : OptionsSettings(),
												],
											),
										),
									)
								],
							),
						),
					),
				),
			),
		);
	}

	Widget ToolsPrompt() {
		return Padding(
			padding: const EdgeInsets.only(left: 20.0, top: 60.0, right: 20.0),
			child: Container (
				height: 300,
				decoration: BoxDecoration (
					shape: BoxShape.rectangle,
					borderRadius: BorderRadius.circular(8.0),

					border: Border.all(
						width: 2,
						color: Colors.blue),
				),
				child: Column (
					children: <Widget>[
						Row(
							mainAxisAlignment: MainAxisAlignment.start,

							children: <Widget>[
								Padding(
									padding: const EdgeInsets.only(left: 15, top: 8),
									child: Text("SETTINGS",
										textAlign: TextAlign.left,
										style: TextStyle(
											fontSize: 20,
											fontWeight: FontWeight.w500,
										),
									),
								),
							],
						),
						Divider(height: 3, thickness: 3,),

						//Here is the SEARCH BAR
//            Container(
//              padding: EdgeInsets.only(top: 3.0),
//              child: searchBar(),
//            ),

						Padding(
							padding: const EdgeInsets.only( top: 8.0, right: 0.5, bottom: 0.0),
							child: FlatButton(
								materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
								child: Row (
									children: <Widget>[
										Icon(Icons.account_circle),
										Padding(
											padding: const EdgeInsets.only(left: 8.0),
											child: Text(
												"My Account"
											),
										),
									],
								),
								// color: Colors.blue,
								onPressed: (){
									setState(() {
										isMyAccountPage = true;
									});
								},
							),
						),
						Padding(
							padding: const EdgeInsets.only(top: 5.0, right: 0.5),
							child: FlatButton(
								materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
								//color: Colors.red,
								child: Row (
									children: <Widget>[
										Icon(Icons.pie_chart),
										Padding(
											padding: const EdgeInsets.only(left: 8.0),
											child: Text("Options"),
										),
									],
								),
								onPressed: (){
									setState(() {
										isMyAccountPage = false;
									});
								},
							),
						),

					],
				),

			),
		);
	}
}