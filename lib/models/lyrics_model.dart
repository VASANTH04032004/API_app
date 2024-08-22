import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Lyrics {
  final String lyrics;

  Lyrics({required this.lyrics});


  factory Lyrics.fromJson(Map<String, dynamic> json) {
    return _$LyricsFromJson(json);
  }


  Map<String, dynamic> toJson() => _$LyricsToJson(this);
}

Lyrics _$LyricsFromJson(Map<String, dynamic> json) {
  return Lyrics(
    lyrics: json['lyrics'] as String? ?? 'No lyrics found.',
  );
}

Map<String, dynamic> _$LyricsToJson(Lyrics instance) {
  return <String, dynamic>{
    'lyrics': instance.lyrics,
  };
}
