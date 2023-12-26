import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather.dart';

class ApiService {
  String apiKey = dotenv.env['API_KEY']!;
  String weatherSearchAPI = "";

  ApiService() {
    weatherSearchAPI = "https://api.weatherapi.com/v1/forecast.json?key=$apiKey&days=7";
  }
  
  Future<Weather> getWeatherData(String countryName) async {
    String requestURL = "$weatherSearchAPI&q=$countryName";
    try {
      var response = await http.get(Uri.parse(requestURL));

      final weatherData = Map<String,dynamic>.from(
        json.decode(response.body) ?? 'No Data'
      );
      return Weather.fromJson(weatherData);
    } catch (e) {
      return Weather(
        locationName: '',
        weatherIcon: '',
        temperature: 0,
        windSpeed: 0,
        humidity: 0,
        cloud: 0,
        pressure: 0,
        visibility: 0,
        currentDate: '',
        isDay: true,
        hourlyWeatherForecast: [],
        dailyWeatherForecast: [],
        currentWeatherCondition: '',
      );
    }
  }


}
