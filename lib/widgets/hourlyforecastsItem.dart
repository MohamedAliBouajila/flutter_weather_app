import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/helpers.dart';

class HourlyForecastsItem extends StatefulWidget {
  final List<dynamic>? weatherPerHour;
  final int index;
  final bool isFistDay;
  const HourlyForecastsItem(
      {Key? key,this.isFistDay = true, required this.index, required this.weatherPerHour})
      : super(key: key);
      

  @override
  State<HourlyForecastsItem> createState() => _HourlyForecastsItemState();
}

class _HourlyForecastsItemState extends State<HourlyForecastsItem> {
   
  @override
  Widget build(BuildContext context) {
    
    final Constants constants = Constants();
    String currentTimeHoure = DateFormat('HH').format(DateTime.now());

    String forecastTime =
        widget.weatherPerHour?[widget.index]["time"].substring(11, 16)  ?? '0';

    String forecastHoure = forecastTime.substring(0, 2);

    String forecastWeatherCondition =
        widget.weatherPerHour?[widget.index]["condition"]["text"] ?? '';

    String forecastWeatherIcon =
        Helpers.getWeatherIconPath(forecastWeatherCondition);

    String forecastTemperature =
        widget.weatherPerHour?[widget.index]["temp_c"].toStringAsFixed(1) ??
            '0';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      margin: const EdgeInsets.only(right: 10, bottom: 2),
      width: 70,
      decoration: BoxDecoration(
          color: currentTimeHoure == forecastHoure && widget.isFistDay
              ? constants.primaryColor
              : constants.primaryColor.withOpacity(.6),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 5,
              color: constants.primaryColor.withOpacity(.1),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            forecastTime,
            style: TextStyle(
              fontSize: 17,
              color: constants.greyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Image.asset(
            'assets/images/day/$forecastWeatherIcon' ,
            width: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                forecastTemperature,
                style: TextStyle(
                  color: constants.greyColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'o',
                style: TextStyle(
                  color: constants.greyColor,
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
