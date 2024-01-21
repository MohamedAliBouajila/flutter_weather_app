import 'package:flutter/material.dart';
import 'package:weather_app/utils/countries.dart';
import 'package:weather_app/utils/helpers.dart';

class Weather{
  String? locationName;
  String? weatherIcon;
  double? temperature;
  double? windSpeed;
  int? humidity;
  int? cloud;
  double? pressure;
  double? visibility;
  String? currentDate;
  bool? isDay;
  List<dynamic>? hourlyWeatherForecast;
  List<dynamic>? dailyWeatherForecast;
  String? currentWeatherCondition;

  Weather({
    this.locationName = '',
    this.weatherIcon = '',
    this.temperature = 0.0,
    this.windSpeed = 0.0,
    this.humidity = 0,
    this.cloud = 0,
    this.pressure = 0.0,
    this.visibility = 0.0,
    this.currentDate = '',
    this.isDay = false,
    this.hourlyWeatherForecast = const [],
    this.dailyWeatherForecast = const [],
    this.currentWeatherCondition = '',
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    String weatherIconPath =
        '${(json["current"]["condition"]["text"])?.toString().replaceAll(' ', '').toLowerCase() ?? ''}.png';
    String countryShortenedName =
        Helpers.getShortNameByName(countries, json["location"]["country"].toString());
    String locationName = '$countryShortenedName / ${json["location"]["region"]}';

    return Weather(
      locationName: locationName,
      weatherIcon: weatherIconPath,
      temperature: json["current"]["temp_c"],
      windSpeed: json["current"]["wind_kph"],
      humidity: json["current"]["humidity"],
      cloud: json["current"]["cloud"],
      pressure: json["current"]["pressure_mb"],
      visibility: json["current"]["vis_km"],
      isDay: json["current"]["is_day"] == 1 ? true : false,
      currentDate: Helpers.getDate(json["location"]["localtime"]),
      hourlyWeatherForecast: json["forecast"]["forecastday"][0]["hour"],
      dailyWeatherForecast: json["forecast"]["forecastday"],
      currentWeatherCondition: json["current"]["condition"]["text"],
    );
  }
}
