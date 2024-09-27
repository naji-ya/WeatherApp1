// class Weather {
//   final String description;
//   final double temperature;
//   final double feelsLike;
//   final int humidity;
//
//   Weather({
//     required this.description,
//     required this.temperature,
//     required this.feelsLike,
//     required this.humidity,
//   });
//
//   factory Weather.fromJson(Map<String, dynamic> json) {
//     return Weather(
//       description: json['weather'][0]['description'],
//       temperature: json['main']['temp'].toDouble(),
//       feelsLike: json['main']['feels_like'].toDouble(),
//       humidity: json['main']['humidity'].toInt(),
//     );
//   }
// }

class Weather {
  final String cityName;
  final String description;
  final double temperature;
  final double feelsLike;
  final int humidity;

  Weather({
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
  });

  // Factory constructor to create a Weather object from JSON
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],  // Extract city name from API response
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      humidity: json['main']['humidity'].toInt(),
    );
  }
}
