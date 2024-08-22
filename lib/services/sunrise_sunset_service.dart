import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ sunrise_sunset_model.dart';

class SunriseSunsetService {
  Future<SunriseSunset> fetchSunriseSunset(double lat, double lng) async {
    final url = 'https://api.sunrise-sunset.org/json?lat=$lat&lng=$lng';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return SunriseSunset.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load sunrise/sunset data');
    }
  }
}
