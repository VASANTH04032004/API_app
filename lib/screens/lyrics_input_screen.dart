import 'package:flutter/material.dart';
import 'lyrics_screen.dart';

class LyricsInputScreen extends StatefulWidget {
  @override
  _LyricsInputScreenState createState() => _LyricsInputScreenState();
}

class _LyricsInputScreenState extends State<LyricsInputScreen> {
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  void _fetchLyrics() {
    final artist = _artistController.text.trim();
    final title = _titleController.text.trim();

    if (artist.isNotEmpty && title.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LyricsScreen(artist: artist, title: title),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both artist and title')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Lyrics Details')),
      body: Column(
        children: [
          // Padding around the top part
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _artistController,
                    decoration: InputDecoration(
                      labelText: 'Artist',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _fetchLyrics,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Get Lyrics'),
            ),
          ),
        ],
      ),
    );
  }
}
