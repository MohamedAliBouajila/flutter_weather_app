import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/helpers.dart';

class HourlyForevastsItem extends StatefulWidget {
  final Weather? weather;
  final int index;
  const HourlyForevastsItem(
      {Key? key, required this.index, required this.weather})
      : super(key: key);
      

  @override
  State<HourlyForevastsItem> createState() => _HourlyForevastsItemState();
}

class _HourlyForevastsItemState extends State<HourlyForevastsItem> {
   
  @override
  Widget build(BuildContext context) {
    
    final Constants _constants = Constants();
    String currentTimeHoure = DateFormat('HH').format(DateTime.now());

    String forecastTime =
        widget.weather?.hourlyWeatherForecast[widget.index]["time"].substring(11, 16);

    String forecastHoure = forecastTime.substring(0, 2);

    String forecastWeatherCondition =
        widget.weather?.hourlyWeatherForecast[widget.index]["condition"]["text"];

    String forecastWeatherIcon =
        Helpers.getWeatherIconPath(forecastWeatherCondition);

    String forecastTemperature =
        widget.weather?.hourlyWeatherForecast[widget.index]["temp_c"].toStringAsFixed(1) ??
            '0';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      margin: const EdgeInsets.only(right: 10, bottom: 2),
      width: 70,
      decoration: BoxDecoration(
          color: currentTimeHoure == forecastHoure
              ? _constants.primaryColor
              : _constants.primaryColor.withOpacity(.6),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 5,
              color: _constants.primaryColor.withOpacity(.1),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            forecastTime,
            style: TextStyle(
              fontSize: 17,
              color: _constants.greyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Image.asset(
            'assets/images/sunny.png',
            width: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                forecastTemperature,
                style: TextStyle(
                  color: _constants.greyColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'o',
                style: TextStyle(
                  color: _constants.greyColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
