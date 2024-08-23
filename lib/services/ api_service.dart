import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ sunrise_sunset_model.dart';
import '../models/lyrics_model.dart';

class Resource<Item> {
  final Item? data;
  final String? error;

  Resource.success(this.data) : error = null;
  Resource.failure(this.error) : data = null;
}

class ApiService {
  Future<Resource<Map<String, dynamic>>> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return Resource.success(json.decode(response.body));
      } else {
        return Resource.failure(
            'Error: ${response.statusCode} ${response.reasonPhrase}');
      }
    } on http.ClientException catch (e) {
      return Resource.failure('ClientException: ${e.message}');
    } on FormatException catch (e) {
      return Resource.failure('FormatException: ${e.message}');
    } on Exception catch (e) {
      return Resource.failure('Exception: ${e.toString()}');
    } catch (e) {
      return Resource.failure('Unknown error: ${e.toString()}');
    }
  }
}

class LyricsService {
  final ApiService _apiService = ApiService();

  Future<Resource<Lyrics>> fetchLyrics(String artist, String title) async {
    try {
      final url = 'https://api.lyrics.ovh/v1/$artist/$title';
      final result = await _apiService.get(url);

      if (result.data != null) {
        return Resource.success(Lyrics.fromJson(result.data!));
      } else {
        return Resource.failure(result.error ?? 'Unknown error occurred');
      }
    } on FormatException catch (e) {
      return Resource.failure('FormatException: ${e.message}');
    } on Exception catch (e) {
      return Resource.failure('Exception: ${e.toString()}');
    } catch (e) {
      return Resource.failure('Unknown error: ${e.toString()}');
    }
  }
}

class SunriseSunsetService {
  final ApiService _apiService = ApiService();

  Future<Resource<SunriseSunset>> fetchSunriseSunset(double lat, double lng) async {
    try {
      final url = 'https://api.sunrise-sunset.org/json?lat=$lat&lng=$lng';
      final result = await _apiService.get(url);

      if (result.data != null) {
        return Resource.success(SunriseSunset.fromJson(result.data!));
      } else {
        return Resource.failure(result.error ?? 'Unknown error occurred');
      }
    } on FormatException catch (e) {
      return Resource.failure('FormatException: ${e.message}');
    } on Exception catch (e) {
      return Resource.failure('Exception: ${e.toString()}');
    } catch (e) {
      return Resource.failure('Unknown error: ${e.toString()}');
    }
  }
}
