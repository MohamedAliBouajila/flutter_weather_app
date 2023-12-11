import 'package:weather_app/utils/helpers.dart';

class Weather {
  String weatherIcon;
  double temperature;
  double windSpeed;
  double humidity;
  double cloud;
  double pressure;
  double visibility;
  String currentDate;
  List<dynamic> hourlyWeatherForecast;
  List<dynamic> dailyWeatherForecast;
  String currentWeatherCondition;

  Weather({
    this.weatherIcon = "",
    this.temperature = 0.0,
    this.windSpeed = 0.0,
    this.humidity= 0.0,
    this.cloud = 0.0,
    this.pressure = 0.0,
    this.visibility = 0.0,
    this.currentDate = "",
    this.hourlyWeatherForecast = const [],
    this.dailyWeatherForecast = const  [],
    this.currentWeatherCondition = "",
  });

  factory Weather.fromJson(Map<String, dynamic> json) {

    String weatherIconPath = '${(json["current"]["condition"]["text"])?.toString().replaceAll(' ', '').toLowerCase() ?? ''}.png';

    return Weather(
      weatherIcon: weatherIconPath,
      temperature: json["current"]["temp_c"] ?? 0.0,
      windSpeed: json["current"]["wind_kph"] ?? 0.0,
      humidity: json["current"]["humidity"] ?? 0.0,
      cloud: json["current"]["cloud"] ?? 0.0,
      pressure: json["current"]["pressure_mb"] ?? 0.0,
      visibility: json["current"]["vis_km"] ?? 0.0,
      currentDate: Helpers.getDate(json["location"]["localtime"]),
      hourlyWeatherForecast: json["hourlyWeatherForecast"] ?? [],
      dailyWeatherForecast: json["dailyWeatherForecast"] ?? [],
      currentWeatherCondition: json["current"]["condition"]["text"] ?? '',
    );
  }
}