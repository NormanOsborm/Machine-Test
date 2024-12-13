
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Wservice/service.dart';


class WeatherScreen extends StatefulWidget {
  final String location;

  WeatherScreen({required this.location});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weatherData;
  final WeatherService weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    weatherData = _fetchWeatherData();
  }

  Future<Map<String, dynamic>> _fetchWeatherData() async {
    return weatherService.getWeather(widget.location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather for ${widget.location}'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: weatherData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitDoubleBounce(
                  color: Colors.blue,
                  size: 50.0,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return _buildWeatherUI(snapshot.data!);
            }
          },
        ),
      ),
    );
  }

  Widget _buildWeatherUI(Map<String, dynamic> data) {
    final temperature = data['main']['temp'];
    final humidity = data['main']['humidity'];
    final weatherCondition = data['weather'][0]['main'];
    final icon = _getWeatherIcon(weatherCondition);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: Colors.blue),
          const SizedBox(height: 16),
          Text('Temperature: $temperature K'),
          const SizedBox(height: 8),
          Text('Humidity: $humidity%'),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition) {
      case 'Clear':
        return WeatherIcons.day_sunny;
      case 'Clouds':
        return WeatherIcons.cloudy;
      case 'Rain':
        return WeatherIcons.rain;
      default:
        return WeatherIcons.day_sunny;
    }
  }
}
