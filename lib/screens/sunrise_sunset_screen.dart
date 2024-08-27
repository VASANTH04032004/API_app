import 'package:flutter/material.dart';
import '../models/ sunrise_sunset_model.dart';
import '../services/ api_service.dart';


class SunriseSunsetScreen extends StatefulWidget {
  @override
  SunriseSunsetScreenState createState() => SunriseSunsetScreenState();
}

class SunriseSunsetScreenState extends State<SunriseSunsetScreen> {
  Future<Resource<SunriseSunset>>? sunriseSunset;
  String? selectedCity;

  final Map<String, Map<String, double>> cityCoordinates = {
    'New York': {'lat': 40.7128, 'lon': -74.0060},
    'Los Angeles': {'lat': 34.0522, 'lon': -118.2437},
    'London': {'lat': 51.5074, 'lon': -0.1278},
    'Tokyo': {'lat': 35.6895, 'lon': 139.6917},
  };

  Future<Resource<SunriseSunset>> fetchSunriseSunsetForCity(String city) {
    final coords = cityCoordinates[city]!;
    return SunriseSunsetService().fetchSunriseSunset(coords['lat']!, coords['lon']!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sunrise and Sunset')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: DropdownButton<String>(
                value: selectedCity,
                hint: Text('Select a city'),
                isExpanded: true,
                items: cityCoordinates.keys.map((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedCity = value;
                      sunriseSunset = fetchSunriseSunsetForCity(selectedCity!);
                    });
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<Resource<SunriseSunset>>(
              future: sunriseSunset,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || snapshot.data is Failure) {
                  return Center(
                    child: Text(
                      'Error: ${(snapshot.data as Failure).errorMessage ?? snapshot.error.toString()}',
                    ),
                  );
                } else if (snapshot.hasData &&
                    snapshot.data is Success<SunriseSunset>) {
                  final data = (snapshot.data as Success<SunriseSunset>).data;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sunrise: ${data.sunrise}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            'Sunset: ${data.sunset}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
