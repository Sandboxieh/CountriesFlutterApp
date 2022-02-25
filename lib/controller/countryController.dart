import 'dart:convert';
import 'dart:io';
import 'dart:math' as Math;
import 'package:http/http.dart' as http;
import 'package:countries_interview_application/model/countryModel.dart';
import 'package:path_provider/path_provider.dart';

class CountryController {
  static const String url =
      'https://us-central1-job-interview-cfe5a.cloudfunctions.net/countries';
  static const double metidelatitude = 45.51067308088129;
  static const double metidelongitude = 12.23434911866721;

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

  //HaverSine formula
  double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(deg2rad(lat1)) *
            Math.cos(deg2rad(lat2)) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  double deg2rad(deg) {
    return deg * (Math.pi / 180);
  }
}
