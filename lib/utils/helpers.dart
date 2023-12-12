import 'package:intl/intl.dart';

class Helpers {
  static String getDate(String localtime){
    var parsedDate =DateTime.parse(localtime.substring(0,10));
    var newDate = DateFormat("MMMMEEEEd").format(parsedDate);
    return newDate;
  }

  static String getShortNameByName(List<Map<String,String>> countries, String nameOfCountry) {
    final country = countries.firstWhere(
      (country) => country["name"]?.toLowerCase() == nameOfCountry.toLowerCase(),
      orElse: () => {'shortName': ''},
    );
    return country['shortName'] ?? '';
  }
}