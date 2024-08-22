import 'package:flutter/material.dart';
import '../models/ sunrise_sunset_model.dart';
import '../services/ api_service.dart';


class SunriseSunsetScreen extends StatefulWidget {
  @override
  SunriseSunsetScreenState createState() => SunriseSunsetScreenState();
}

class SunriseSunsetScreenState extends State<SunriseSunsetScreen> {
  late Future<Resource<SunriseSunset>> sunriseSunset;

  @override
  void initState() {
    super.initState();
    sunriseSunset = SunriseSunsetService().fetchSunriseSunset(36.7201600, -4.4203400);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sunrise and Sunset')),
      body: FutureBuilder<Resource<SunriseSunset>>(
        future: sunriseSunset,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data?.error != null) {
            return Center(child: Text('Error: ${snapshot.data?.error ?? snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data?.data != null) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sunrise: ${snapshot.data!.data!.sunrise}'),
                  Text('Sunset: ${snapshot.data!.data!.sunset}'),
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
