import 'package:countries_interview_application/view/noteList.dart';
import 'package:flutter/material.dart';
import 'package:countries_interview_application/model/countryModel.dart';

class CountryDetailsPage extends StatelessWidget {
  final Country country;
  CountryDetailsPage({Key key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            valueColor: AlwaysStoppedAnimation(Colors.orange)),
      ),
    );

    final countryCode = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        country.code2L,
        style: TextStyle(color: Colors.white),
      ),
    );

    final topContentText = SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.network(
          country.flag,
          width: 40,
          height: 40,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          country.name,
          style: TextStyle(color: Colors.white, fontSize: 25.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      country.code3L,
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(flex: 1, child: countryCode)
          ],
        ),
      ],
    ));

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/metidecrossplatform.jpg"),
                fit: BoxFit.fill,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      'Full name:\n' + country.nameOfficial,
      style: TextStyle(fontSize: 18.0),
    );
    final bottomLongitudeText = Text(
      'Longitude:\n' + country.longitude,
      style: TextStyle(fontSize: 18.0),
    );
    final bottomLatitudeText = Text(
      'Latitude:\n' + country.latitude,
      style: TextStyle(fontSize: 18.0),
    );
    final floatingActionButton = FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoteScreen(countryid: country.id)));
      },
      label: const Text('Notes'),
      icon: const Icon(Icons.note),
      backgroundColor: Colors.blueAccent,
    );
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(25.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            bottomContentText,
            bottomLongitudeText,
            bottomLatitudeText
          ],
        ),
      ),
    );

    return Scaffold(
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
