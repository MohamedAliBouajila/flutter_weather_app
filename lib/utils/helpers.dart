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
    
  static void scrollToItem(ScrollController scrollController) {
    DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('HH');
    final index = int.parse(formatter.format(now));
  
    double itemExtent = 80;
    double offset = index * itemExtent;
    
    scrollController.animateTo(
      offset,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

}