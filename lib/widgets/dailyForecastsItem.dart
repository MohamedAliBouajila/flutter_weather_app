import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/dayforecast.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/helpers.dart';

class DailyForecastsItem extends StatefulWidget {
  final DayForecast? weather;
  final String day;
  final int index;
  const DailyForecastsItem(
      {Key? key, required this.index, required this.weather, required this.day})
      : super(key: key);
      

  @override
  State<DailyForecastsItem> createState() => _DailyForecastsItemState();
}

class _DailyForecastsItemState extends State<DailyForecastsItem> {
   
  @override
  Widget build(BuildContext context) {
    
    final Constants _constants = Constants();
    Size size = MediaQuery.of(context).size;
    String formattedDate = DateFormat('ddMMM, EEEE').format(widget.weather!.date);
    String day = formattedDate.substring(6,10);

    bool isToday = widget.day == formattedDate.substring(0,2);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      margin: const EdgeInsets.only(right: 12),
      width: size.width * 0.12,
      decoration: BoxDecoration(
          color: isToday
              ? _constants.tertiaryColor
              : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
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
          Image.asset(
            'assets/images/sunny.png',
            width: 20,
          ),
          Text(
            widget.weather!.date.toString().substring(8, 10),
            style: TextStyle(
              fontSize: 25,
              color: isToday? _constants.greyColor:_constants.tertiaryColor,
              fontWeight: FontWeight.bold,
            ),
          ), 
          Text(
             day,
            style: TextStyle(
              fontSize: 17,
              color: isToday? _constants.greyColor:_constants.tertiaryColor,
              fontWeight: FontWeight.w500,
            ),
          ), 
            ],
      ),
    );
  }
}
