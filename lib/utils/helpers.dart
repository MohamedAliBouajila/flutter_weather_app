import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helpers {
  static String getDate(String localtime){
    var parsedDate =DateTime.parse(localtime.substring(0,10));
    var newDate = DateFormat("MMMMEEEEd").format(parsedDate);
    return newDate;
  }

  static String getWeatherIconPath(String weatherCondition){
    return '${weatherCondition.replaceAll(' ', '').toLowerCase()}.png';
  }

  static String getShortNameByName(List<Map<String,String>> countries, String nameOfCountry) {
    final country = countries.firstWhere(
      (country) => country["name"]?.toLowerCase() == nameOfCountry.toLowerCase(),
      orElse: () => {'shortName': ''},
    );
    return country['shortName'] ?? '';
  }
   static ScrollController scrollController = ScrollController();
   static void scrollToItem(int index) {
    double itemExtent = 50.0;
    double offset = index * itemExtent;
    
    scrollController.animateTo(
      offset,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}