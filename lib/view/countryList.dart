import 'package:flutter/material.dart';

class CountriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Countries List"),
        automaticallyImplyLeading: false,
      ),
      body: new Center(
        child: new Text(
          "Fetch Api :)",
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
      ),
    );
  }
}
