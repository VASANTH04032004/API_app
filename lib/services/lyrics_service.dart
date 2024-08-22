import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/lyrics_model.dart';

class LyricsService {
  Future<Lyrics> fetchLyrics(String artist, String title) async {
    final url = 'https://api.lyrics.ovh/v1/$artist/$title';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Lyrics.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load lyrics');
    }
  }
}
