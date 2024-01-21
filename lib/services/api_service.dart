import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/providers/weather_provider.dart';

class ApiService {
  final WeatherProvider weatherProvider;
  final String  weatherSearchAPI = "https://api.weatherapi.com/v1/forecast.json?key=${dotenv.env['API_KEY']!}&days=7";

  ApiService(this.weatherProvider);

  Future<void> getAndUpdateWeatherData(String countryName) async {
    String requestURL = "$weatherSearchAPI&q=$countryName";
    try {
      var response = await http.get(Uri.parse(requestURL));

      final weatherData = Map<String, dynamic>.from(
        json.decode(response.body) ?? 'No Data',
      );
      final weather = Weather.fromJson(weatherData);
      weatherProvider.updateWeather(weather);
    } catch (e) {
      print(e);
    }
  }
}