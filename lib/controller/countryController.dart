import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:countries_interview_application/model/countryModel.dart';
import 'package:path_provider/path_provider.dart';

class CountryController {
  static const String url =
      'https://us-central1-job-interview-cfe5a.cloudfunctions.net/countries';

  static Future<List<Country>> getCountries() async {
    String username = 'developer';
    String password = 'metide';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String fileName = 'countriesList.json';
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      // Read from cache
      final data = file.readAsStringSync();
      List res = json.decode(data);
      return res.map((res) => new Country.fromJson(res)).toList();
    } else {
      // Fetch from network
      final response = await http
          .get(url, headers: <String, String>{'authorization': basicAuth});
      if (response.statusCode == 200) {
        // Save to json cache
        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);
        List countryList = json.decode(response.body);
        return countryList
            .map((countryList) => new Country.fromJson(countryList))
            .toList();
      } else {
        throw Exception('Error');
      }
    }
  }
}
