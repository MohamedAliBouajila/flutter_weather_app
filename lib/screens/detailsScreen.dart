import 'package:flutter/material.dart';
import 'package:weather_app/utils/constants.dart';

class DetailsPage extends StatefulWidget {
  final List<dynamic> dailyWeatherForecast;
  const DetailsPage({super.key, required this.dailyWeatherForecast});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final Constants _constants = Constants();

  @override
  Widget build(BuildContext context) {

  Size size = MediaQuery.of(context).size;
  List<dynamic> dailyWeatherForecast = widget.dailyWeatherForecast;


  Map forecastDetails(int index) {
    return {
      "date": dailyWeatherForecast[index]["date"],
      "maxtemp_c": dailyWeatherForecast[index]["day"]["maxtemp_c"],
      "mintemp_c": dailyWeatherForecast[index]["day"]["mintemp_c"],
      "avgtemp_c": dailyWeatherForecast[index]["day"]["avgtemp_c"],
      "maxwind_kph": dailyWeatherForecast[index]["day"]["maxwind_kph"],
      "totalprecip_mm": dailyWeatherForecast[index]["day"]["totalprecip_mm"],
      "avgvis_km": dailyWeatherForecast[index]["day"]["avgvis_km"],
      "uv": dailyWeatherForecast[index]["day"]["uv"],
      "condition": dailyWeatherForecast[index]["day"]["condition"],
    };

  }
    return Scaffold(
      backgroundColor: _constants.primaryColor,
      appBar: AppBar(
        title: const Text('Forecasts', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: _constants.primaryColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings,color: Colors.white,),
          ),
        ],
      ),
      body: Stack(alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            height: size.height * .60,
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40)
              )
            ),
            child: Stack(clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -30,
                  left: 25,
                  right: 25,
                  child: Container(
                    height: 250,
                    width: size.width * .5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                       borderRadius:BorderRadius.all(
                          Radius.circular(20)
                       ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 1),
                          blurRadius: 5,
                          color: _constants.primaryColor.withOpacity(.1),
                        ),
                      ]
                    ),
                  ),
                ),
                
              ],
            )
          ),
        ),
      ]
         ));
      
  }
}