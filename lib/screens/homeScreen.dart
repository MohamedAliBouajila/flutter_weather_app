import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/services/apiService.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  
  String location = 'Tunisia';
 
  Weather? weather;

  Future<void> getData() async {
    var data = await apiService.getWeatherData(location);
    setState(() {
      weather = data;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    if (weather == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  print(weather!.currentDate);
    return Scaffold(
      body: Container(
        child: Text("Weather data loaded!"),
      ),
    );
  }
}
