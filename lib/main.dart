import 'package:flutter/material.dart';
import 'package:countries_interview_application/view/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countries Interview App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xff4f359b)),
      home: Splashscreen(),
    );
  }
}
