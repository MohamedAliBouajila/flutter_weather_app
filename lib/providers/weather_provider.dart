import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';

class WeatherProvider with ChangeNotifier {
  Weather _weather = Weather();

  Weather get weather => _weather;

  void updateWeather(Weather newWeather) {
    _weather = newWeather;
    notifyListeners();
  }
}
