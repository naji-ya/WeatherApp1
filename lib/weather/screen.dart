// import 'package:flutter/material.dart';
// import 'package:weathervs/weather/service.dart';
//
// import 'modelclass.dart';
//
// class WeatherScreen extends StatefulWidget {
//   @override
//   _WeatherScreenState createState() => _WeatherScreenState();
// }
//
// class _WeatherScreenState extends State<WeatherScreen> {
//   final WeatherService weatherService = WeatherService();
//   Weather? _weather;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather App'),
//       ),
//       body: Center(
//         child: _weather == null
//             ? ElevatedButton(
//           onPressed: () async {
//             final weather = await weatherService.fetchWeather('delhi');
//             setState(() {
//               _weather = weather;
//             });
//           },
//           child: Text('Get Weather'),
//         )
//             : Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Description: ${_weather!.description}'),
//             Text('Temperature: ${_weather!.temperature}°C'),
//             Text('Feels Like: ${_weather!.feelsLike}°C'),
//             Text('Humidity: ${_weather!.humidity}%'),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weathervs/weather/service.dart';
import 'modelclass.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService weatherService = WeatherService();
  Weather? _weather;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getLocationAndWeather();
  }

  // Method to get the user's current location and fetch the weather
  Future<void> _getLocationAndWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Check location permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'Location services are disabled.';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Location permissions are denied';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'Location permissions are permanently denied.';
      }

      // Get the user's current position (latitude and longitude)
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Fetch weather data based on the current location
      Weather weather = await weatherService.fetchWeather(
          position.latitude, position.longitude);

      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Center(
        child: _isLoading
            ? CircularProgressIndicator() // Show loading indicator while fetching data
            : _weather == null
            ? Text('Failed to fetch weather.')
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'City: ${_weather!.cityName}', // Display city name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('Description: ${_weather!.description}'),
            Text('Temperature: ${_weather!.temperature}°C'),
            Text('Feels Like: ${_weather!.feelsLike}°C'),
            Text('Humidity: ${_weather!.humidity}%'),
            SizedBox(height: 20),
            Image.asset(_getWeatherImage(_weather!.description)),
          ],
        ),
      ),
    );
  }

  // Helper method to return an image asset based on weather description
  String _getWeatherImage(String description) {
    if (description.contains("rain")) {
      return 'assets/images/rainy.png';
    } else if (description.contains("cloud")) {
      return 'assets/images/cloudy.png';
    } else if (description.contains("clear")) {
      return 'assets/images/clear.png';
    } else {
      return 'assets/images/default.png';
    }
  }
}
