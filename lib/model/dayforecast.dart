import 'package:weather_app/utils/countries.dart';
import 'package:weather_app/utils/helpers.dart';

class DayForecast {
  DateTime date;
  String weatherIcon;
  double minTemperature;
  double maxTemperature;
  double maxWindSpeed;
  int avgHumidity;
  double totalPrecipMM;
  double totalSnowCM;
  double avgVisibility;
  List<dynamic> hourlyWeatherForecast;
  String currentWeatherCondition;

  DayForecast({
    required this.date,
    required this.weatherIcon,
    required this.minTemperature,
    required this.maxTemperature,
    required this.maxWindSpeed,
    required this.avgHumidity,
    required this.totalPrecipMM,
    required this.totalSnowCM,
    required this.avgVisibility,
    required this.hourlyWeatherForecast,
    required this.currentWeatherCondition,
  });


  factory DayForecast.fromJson(Map<String, dynamic> json) {

    String weatherIconPath = '${(json["current"]["condition"]["text"])?.toString().replaceAll(' ', '').toLowerCase() ?? ''}.png';
   
    return DayForecast(
      date: json["date"],
      weatherIcon: weatherIconPath,
      minTemperature: json["day"]["mintemp_c"],
      maxTemperature: json["day"]["maxtemp_c"],
      maxWindSpeed: json["day"]["maxwind_kph"],
      avgHumidity: json["day"]["avghumidity"],
      totalPrecipMM: json["day"]["totalprecip_mm"],
      totalSnowCM: json["day"]["totalsnow_cm"],
      avgVisibility: json["day"]["avgvis_km"],
      hourlyWeatherForecast: json["hour"],
      currentWeatherCondition: json["day"]["condition"]["text"],
    );
  }
}