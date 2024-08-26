import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ sunrise_sunset_model.dart';
import '../models/lyrics_model.dart';


abstract class Resource<Item> {}


class Success<Item> extends Resource<Item> {
  final Item data;

  Success(this.data);
}


class Failure<Item> extends Resource<Item> {
  final String? errorMessage;
  final Exception? exception;
  final Error? error;

  Failure({this.errorMessage, this.exception, this.error});
}

class ApiService {
  Future<Resource<Item>> fetchData<Item>(String url, Item Function(String) fromJson) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode < 300) {
        print("Response: ${response.body}");
        return Success<Item>(fromJson(json.decode(response.body)));
      } else if (response.statusCode >= 500) {
        return Failure(errorMessage: "500: Server Error");
      } else {
        return Failure(errorMessage: "Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } on http.ClientException catch (e) {
      return Failure(errorMessage: 'ClientException: ${e.message}');
    } on FormatException catch (e) {
      return Failure(errorMessage: 'FormatException: ${e.message}');
    } on Exception catch (e) {
      return Failure(errorMessage: 'Exception: ${e.toString()}');
    } catch (e) {
      return Failure(errorMessage: 'Unknown error: ${e.toString()}');
    }
  }
}

class LyricsService {
  final ApiService _apiService = ApiService();

  Future<Resource<Lyrics>> fetchLyrics(String artist, String title) async {
    final url = 'https://api.lyrics.ovh/v1/$artist/$title';
    return await _apiService.fetchData(url, (body) => Lyrics.fromJson(jsonDecode(body)));
  }
}

class SunriseSunsetService {
  final ApiService _apiService = ApiService();

  Future<Resource<SunriseSunset>> fetchSunriseSunset(double lat, double lng) async {
    final url = 'https://api.sunrise-sunset.org/json?lat=$lat&lng=$lng';
    return await _apiService.fetchData(url, (body) => SunriseSunset.fromJson(jsonDecode(body)));
  }
}
