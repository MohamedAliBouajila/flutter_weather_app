import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/dayforecast.dart';
import 'package:weather_app/screens/homeScreen.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/helpers.dart';
import 'package:weather_app/widgets/dailyForecastsItem.dart';
import 'package:weather_app/widgets/hourlyforecastsItem.dart';
import 'package:weather_app/widgets/weatherItem.dart';

class DetailsPage extends StatefulWidget {
  final List<dynamic> dailyWeatherForecast;

  const DetailsPage({super.key, required this.dailyWeatherForecast});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final Constants _constants = Constants();
  final ScrollController _scrollController = ScrollController();
  DayForecast? tomorrowForecast;
  DayForecast? dayForcecast;
  DateTime startDay = DateTime.now();
  DateTime? endDay;
  DateTime dayData = DateTime.now();

  @override
  void initState() {
    endDay =  DateTime.parse(widget.dailyWeatherForecast.last['date']);
    dayForcecast = DayForecast.fromJson(widget.dailyWeatherForecast.firstWhere(
      (map) => map['date'] == DateFormat('yyyy-MM-dd').format(startDay),
      orElse: () => [],
    ));
    tomorrowForecast = DayForecast.fromJson(widget.dailyWeatherForecast.firstWhere(
      (map) =>
          map['date'] ==
          DateFormat('yyyy-MM-dd').format(startDay.add(const Duration(days: 1))),
      orElse: () => [],
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<dynamic> dailyWeatherForecast = widget.dailyWeatherForecast;

    final List<Widget> gridItems = [
      WeatherItem(
        icon: 'wind.png',
        unit: 'km/h',
        value: '${dayForcecast?.maxWindSpeed ?? 0}',
      ),
      WeatherItem(
        icon: 'humidity.png',
        unit: '%',
        value: '${dayForcecast?.avgHumidity ?? 0}',
      ),
      WeatherItem(
        icon: 'cloud.png',
        unit: 'Okta',
        value: '${dayForcecast?.totalPrecipMM ?? 0}',
      ),
      WeatherItem(
        icon: 'pressure.png',
        unit: 'mb',
        value: '${dayForcecast?.avgVisibility ?? 0}',
      ),
      WeatherItem(
        icon: 'pressure.png',
        unit: 'mb',
        value: '${dayForcecast?.totalSnowCM ?? 0}',
      ),
    ];
     WidgetsBinding.instance.addPostFrameCallback((_) {
      startDay==dayData ? Helpers.scrollToItem(_scrollController) : _scrollController.animateTo(
      0,
      duration:const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    });


    return Scaffold(
        backgroundColor: _constants.primaryColor,
        appBar: AppBar(
          title: const Text(
            'Forecasts',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: _constants.primaryColor,
          
        ),
        body: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 10,
              left: 35,
              right: 35,
              child: SizedBox(
                height: 120,
                width: size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: dailyWeatherForecast.length,
                  itemBuilder: (BuildContext context, int index) {
                    return 
                   GestureDetector(
                    onTap: (){
        
                      setState(() {

                        dayData =  index < 7?dayData.add(const Duration(days: 1)):dayData;
                        dayForcecast = DayForecast.fromJson(dailyWeatherForecast[index]);

                        tomorrowForecast  = index < 7? DayForecast.fromJson(dailyWeatherForecast[index+1]):null;
                      });
                    },  
                    child: DailyForecastsItem(
                        day:DateFormat('dd').format(dayData),
                        index: index,
                        weather:
                            DayForecast.fromJson(dailyWeatherForecast[index])),
                   ) ;
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: size.height * .60,
                width: size.width,
                decoration: BoxDecoration(
                  color: _constants.tertiaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -140,
                      left: 10,
                      right: 10,
                      child: Container(
                        height: size.height * .80,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                      Container(
                        padding:const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          gradient: _constants.linearGradientBlue,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 1),
                              blurRadius: 5,
                              color: _constants.primaryColor.withOpacity(.5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                         left: -35,
                                          top: -35,
                                        child: Image.asset(
                                           'assets/images/sunny.png',
                                           width: 180,
                                         ),
                                      ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                               width: 150,
                                                height: 150,
                                            ),
                                            Text(
                                              dayForcecast!.currentWeatherCondition,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('ddMMM, EEEE')
                                                    .format(dayData)
                                                    .toString()  ==  DateFormat('ddMMM, EEEE')
                                                    .format(DateTime.now())
                                                    .toString() ? 
                                             'Tonight' : 
                                              DateFormat('ddMMM, EEEE')
                                                    .format(dayData)
                                                    .toString(),   
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),            
                                      Text(
                                        dayForcecast!.currentWeatherCondition,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 21,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 110,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: gridItems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return gridItems[index];
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                            
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: SizedBox(
                                  height: 110,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: dayForcecast!
                                        .hourlyWeatherForecast.length,
                                    controller: _scrollController,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return HourlyForecastsItem(
                                        index: index,
                                        weatherPerHour:
                                            dayForcecast?.hourlyWeatherForecast,
                                      );
                                    },
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  dayData = dayData.add(const Duration(days: 1));
                                  dayForcecast = DayForecast.fromJson(widget.dailyWeatherForecast.firstWhere(
                            (map) => map['date'] == DateFormat('yyyy-MM-dd').format(dayData),
                            orElse: () => null,
                          ));
                          tomorrowForecast = DayForecast.fromJson(widget.dailyWeatherForecast.firstWhere(
                            (map) =>
                                map['date'] ==
                                DateFormat('yyyy-MM-dd').format(dayData.add(const Duration(days: 1))),
                            orElse: () => null,
                          ));
                           
                                });
                      
                              },
                              child:
                            Container(
                              height: 140,
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              decoration: BoxDecoration(
                                gradient: _constants.linearGradientBlue,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 1),
                                    blurRadius: 5,
                                    color:
                                        _constants.primaryColor.withOpacity(.5),
                                  ),
                                ],
                              ),
                              child: 
                              dayData == endDay ? const Center(child: Text('No more data')) :
                              Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: 
                              [  Positioned(
                                      top: -17,
                                      left: -50,                               
                                      child: Image.asset(
                                        'assets/images/sunny.png',
                                        width: 150,
                                      ),
                                    ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 100,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          tomorrowForecast!
                                              .currentWeatherCondition,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 21,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              DateFormat('ddMMM, ')
                                                  .format(tomorrowForecast!.date)
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('EEEE')
                                                  .format(tomorrowForecast!.date)
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${tomorrowForecast!.minTemperature.toString()}/${tomorrowForecast!.maxTemperature.toString()} °',
                                          style: const TextStyle(
                                            color: Colors.white54,
                                            fontSize: 19,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon:const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                           ]   ),
                            ),
                        )],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
