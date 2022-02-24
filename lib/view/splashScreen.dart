import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:countries_interview_application/view/countryList.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => new _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      title: new Text(
        'Welcome To Metide',
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),
      ),
      seconds: 3,
      navigateAfterSeconds: CountriesList(),
      image: new Image.asset('assets/images/metidelogo.png'),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 200.0,
      loaderColor: Colors.white,
    );
  }
}
