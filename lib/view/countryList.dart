import 'package:countries_interview_application/view/countryDetails.dart';
import 'package:flutter/material.dart';
import 'package:countries_interview_application/controller/countryController.dart';
import 'package:countries_interview_application/model/countryModel.dart';

class CountriesList extends StatefulWidget {
  //
  CountriesList() : super();
  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  //
  List<Country> _countries;
  bool _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    CountryController.getCountries().then((countries) {
      setState(() {
        _countries = countries;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(country) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.black))),
            child: Image.network(
              country.flag,
              width: 70,
              height: 70,
            ),
          ),
          title: Text(
            country.name,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    child: LinearProgressIndicator(
                        backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                        value: 100,
                        valueColor: AlwaysStoppedAnimation(Colors.green)),
                  )),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(country.code2L,
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold))),
              )
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.blue[900], size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CountryDetailsPage(country: country)));
          },
        );

    Card makeCard(Country country) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, .9)),
            child: makeListTile(country),
          ),
        );

    final makeBody = RefreshIndicator(
        onRefresh: () async {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (a, b, c) => CountriesList(),
              transitionDuration: Duration(seconds: 1),
            ),
          );
          return;
        },
        child: Container(
          child: FutureBuilder(
              future: CountryController.getCountries(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return (Center(child: CircularProgressIndicator()));
                }
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: null == _countries ? 0 : _countries.length,
                  itemBuilder: (context, index) {
                    Country country = _countries[index];
                    return makeCard(country);
                  },
                );
              }),
        ));

    final topAppBar = AppBar(
      elevation: 0.1,
      automaticallyImplyLeading: false,
      title: Text(_loading ? 'Loading...' : 'Countries List'),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      appBar: topAppBar,
      body: makeBody,
    );
  }
}
