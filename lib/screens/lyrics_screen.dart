import 'package:flutter/material.dart';
import '../models/lyrics_model.dart';
import '../services/lyrics_service.dart';

class LyricsScreen extends StatefulWidget {
  @override
  LyricsScreenState createState() => LyricsScreenState();
}

class LyricsScreenState extends State<LyricsScreen> {
  late Future<Lyrics> lyrics;

  @override
  void initState() {
    super.initState();
    lyrics = LyricsService().fetchLyrics('Coldplay', 'Yellow');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lyrics')),
      body: FutureBuilder<Lyrics>(
        future: lyrics,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                snapshot.data!.lyrics,
                style: const TextStyle(fontSize: 16.0),
              ),
            );
          } else {
            return Center(child: Text('No lyrics found.'));
          }
        },
      ),
    );
  }
}
