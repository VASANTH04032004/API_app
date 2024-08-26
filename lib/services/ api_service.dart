import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ sunrise_sunset_model.dart';
import '../models/lyrics_model.dart';


abstract class Resource<T> {}

class Success<T> extends Resource<T> {
  final T data;

  Success(this.data);
}

class Failure<T> extends Resource<T> {
  final String? errorMessage;
  final Exception? exception;
  final Error? error;

  Failure({this.errorMessage, this.exception, this.error});
}


class ApiService {
  Future<Resource<T>> fetchData<T>(String url, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode < 300) {
        final data = fromJson(json.decode(response.body) as Map<String, dynamic>);
        return Success<T>(data);
      } else if (response.statusCode >= 500) {
        return Failure(errorMessage: "500: Server Error");
      } else {
        return Failure(errorMessage: "Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } on http.ClientException catch (e) {
      return Failure(errorMessage: 'ClientException: ${e.message}', exception: e);
    } on FormatException catch (e) {
      return Failure(errorMessage: 'FormatException: ${e.message}', exception: e);
    } on Exception catch (e) {
      return Failure(errorMessage: 'Exception: ${e.toString()}', exception: e);
    } on Error catch (e) {
      return Failure(errorMessage: 'Error: ${e.toString()}', error: e);
    } catch (e) {
      return Failure(errorMessage: 'Unknown error: ${e.toString()}');
    }
  }
}

class LyricsService {
  final ApiService _apiService = ApiService();

  Future<Resource<Lyrics>> fetchLyrics(String artist, String title) async {
    final url = 'https://api.lyrics.ovh/v1/$artist/$title';
    return await _apiService.fetchData(url, (json) => Lyrics.fromJson(json));
  }
}

class SunriseSunsetService {
  final ApiService _apiService = ApiService();

  Future<Resource<SunriseSunset>> fetchSunriseSunset(double lat, double lng) async {
    final url = 'https://api.sunrise-sunset.org/json?lat=$lat&lng=$lng';
    return await _apiService.fetchData(url, (json) => SunriseSunset.fromJson(json));
  }
}
