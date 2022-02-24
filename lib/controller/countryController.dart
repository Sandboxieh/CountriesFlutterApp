import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:countries_interview_application/model/countryModel.dart';

class CountryController {
  static const String url =
      'https://us-central1-job-interview-cfe5a.cloudfunctions.net/countries';

  static Future<List<Country>> getCountries() async {
    String username = 'developer';
    String password = 'metide';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await http
        .get(url, headers: <String, String>{'authorization': basicAuth});
    if (response.statusCode == 200) {
      List countryList = json.decode(response.body);
      return countryList
          .map((countryList) => new Country.fromJson(countryList))
          .toList();
    } else {
      throw Exception('Error');
    }
  }
}
