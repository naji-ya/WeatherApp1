// import 'dart:convert';
// import 'package:http/http.dart 'as http;
//
// import 'modelclass.dart';
//
//
//
// class WeatherService {
//   final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
//   final String apiKey = '271c27e1864cb13a9c8a65734c3d3080'; // Directly put your API key here.
//
//   Future<Weather> fetchWeather(String cityName) async {
//     final response = await http.get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'));
//
//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body);
//       return Weather.fromJson(json);
//     } else {
//       throw Exception('Failed to load weather');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'modelclass.dart';

class WeatherService {
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = '271c27e1864cb13a9c8a65734c3d3080'; // Your API Key

  // Fetch weather by city name (for future use)
  Future<Weather> fetchWeatherByCityName(String cityName) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load weather');
    }
  }

  // Fetch weather by latitude and longitude
  Future<Weather> fetchWeather(double latitude, double longitude) async {
    final response = await http.get(Uri.parse(
        '$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
