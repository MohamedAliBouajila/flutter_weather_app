import 'package:weather_app/utils/countries.dart';
import 'package:weather_app/utils/helpers.dart';

class Weather {
  String locationName;
  String weatherIcon;
  double temperature;
  double windSpeed;
  int humidity;
  int cloud;
  double pressure;
  double visibility;
  String currentDate;
  List<dynamic> hourlyWeatherForecast;
  List<dynamic> dailyWeatherForecast;
  String currentWeatherCondition;

  Weather({
    required this.locationName,
    required this.weatherIcon,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.cloud,
    required this.pressure,
    required this.visibility,
    required this.currentDate,
    required this.hourlyWeatherForecast,
    required this.dailyWeatherForecast,
    required this.currentWeatherCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {

    String weatherIconPath = '${(json["current"]["condition"]["text"])?.toString().replaceAll(' ', '').toLowerCase() ?? ''}.png';
    String countryShortenedName = Helpers.getShortNameByName(countries,json["location"]["country"].toString());
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
      currentDate: Helpers.getDate(json["location"]["localtime"]),
      hourlyWeatherForecast: json["forecast"]["forecastday"][0]["hour"],
      dailyWeatherForecast: json["forecast"]["forecastday"],
      currentWeatherCondition: json["current"]["condition"]["text"],
    );
  }
}