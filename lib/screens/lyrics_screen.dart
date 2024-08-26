import 'package:flutter/material.dart';
import '../models/lyrics_model.dart';
import '../services/ api_service.dart';

class LyricsScreen extends StatefulWidget {
  final String artist;
  final String title;

  LyricsScreen({required this.artist, required this.title});

  @override
  LyricsScreenState createState() => LyricsScreenState();
}

class LyricsScreenState extends State<LyricsScreen> {
  late Future<Resource<Lyrics>> lyrics;

  @override
  void initState() {
    super.initState();
    lyrics = LyricsService().fetchLyrics(widget.artist, widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lyrics')),
      body: FutureBuilder<Resource<Lyrics>>(
        future: lyrics,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data is Failure) {
            return Center(child: Text('Error: ${(snapshot.data as Failure).errorMessage ?? snapshot.error.toString()}'));
          } else if (snapshot.hasData && snapshot.data is Success<Lyrics>) {
            final data = (snapshot.data as Success<Lyrics>).data;
            if (data.lyrics?.isNotEmpty ?? false) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  data.lyrics ?? 'No lyrics available.',
                  style: const TextStyle(fontSize: 16.0),
                ),
              );
            } else {
              return Center(
                child: Text('No lyrics found for ${widget.artist} - ${widget.title}.'),
              );
            }
          } else {
            return Center(child: Text('Unexpected error occurred.'));
          }
        },
      ),
    );
  }
}
