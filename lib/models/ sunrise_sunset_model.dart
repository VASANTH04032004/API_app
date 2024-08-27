import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SunriseSunset {
  final String sunrise;
  final String sunset;

  SunriseSunset({required this.sunrise, required this.sunset});

  factory SunriseSunset.fromJson(Map<String, dynamic> json) {
    final results = json['results'] as Map<String, dynamic>;
    return SunriseSunset(
      sunrise: results['sunrise'] as String,
      sunset: results['sunset'] as String,
    );
  }

  Map<String, dynamic> toJson() => _$SunriseSunsetToJson(this);
}

Map<String, dynamic> _$SunriseSunsetToJson(SunriseSunset instance) {
  return <String, dynamic>{
    'sunrise': instance.sunrise,
    'sunset': instance.sunset,
  };
}

