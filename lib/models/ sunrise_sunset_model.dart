class SunriseSunset {
  final String sunrise;
  final String sunset;

  SunriseSunset({required this.sunrise, required this.sunset});

  factory SunriseSunset.fromJson(Map<String, dynamic> json) {
    return SunriseSunset(
      sunrise: json['results']['sunrise'],
      sunset: json['results']['sunset'],
    );
  }
}
