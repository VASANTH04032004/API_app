import 'package:flutter/material.dart';
import '../models/ sunrise_sunset_model.dart';
import '../services/sunrise_sunset_service.dart';

class SunriseSunsetScreen extends StatefulWidget {
  @override
  SunriseSunsetScreenState createState() => SunriseSunsetScreenState();
}

class SunriseSunsetScreenState extends State<SunriseSunsetScreen> {
  late Future<SunriseSunset> sunriseSunset;

  @override
  void initState() {
    super.initState();
    sunriseSunset = SunriseSunsetService().fetchSunriseSunset(36.7201600, -4.4203400);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sunrise and Sunset')),
      body: FutureBuilder<SunriseSunset>(
        future: sunriseSunset,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sunrise: ${snapshot.data!.sunrise}'),
                  Text('Sunset: ${snapshot.data!.sunset}'),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
