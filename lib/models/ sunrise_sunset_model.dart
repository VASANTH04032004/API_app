import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SunriseSunset {
  final String sunrise;
  final String sunset;

  SunriseSunset({required this.sunrise, required this.sunset});


  factory SunriseSunset.fromJson(Map<String, dynamic> json) =>
      _$SunriseSunsetFromJson(json);


  Map<String, dynamic> toJson() => _$SunriseSunsetToJson(this);
}


Map<String, dynamic> _$SunriseSunsetToJson(SunriseSunset instance) {
  return <String, dynamic>{
    'sunrise': instance.sunrise,
    'sunset': instance.sunset,
  };
}

SunriseSunset _$SunriseSunsetFromJson(Map<String, dynamic> json) {
  return SunriseSunset(
    sunrise: json['sunrise'] as String,
    sunset: json['sunset'] as String,
  );
}
