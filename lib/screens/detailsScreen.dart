import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/dayforecast.dart';
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
  DayForecast? dayForcecast;
  DayForecast? tomorrowForecast;
  int nbrOfDAys = 0;
  int? activeItem;

  @override
  void initState() {
    activeItem = 0;
    nbrOfDAys = widget.dailyWeatherForecast.length;
    dayForcecast = DayForecast.fromJson(widget.dailyWeatherForecast.firstWhere(
      (map) => map['date'] == DateFormat('yyyy-MM-dd').format(DateTime.now()),
      orElse: () => [],
    ));
    tomorrowForecast = DayForecast.fromJson(widget.dailyWeatherForecast.firstWhere(
      (map) =>
          map['date'] ==
          DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 1))),
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
        fontsize: 15,
      ),
      WeatherItem(
        icon: 'humidity.png',
        unit: '%',
        value: '${dayForcecast?.avgHumidity ?? 0}',
        fontsize: 15,
      ),
      WeatherItem(
                    icon: 'snow.png',
                    unit: 'cm',
                    value: '${dayForcecast?.totalSnowCM ?? 0}',
                    fontsize: 15,
                  ), 
      WeatherItem(
        icon: 'visibility.png',
        unit: 'Km',
        value: '${dayForcecast?.avgVisibility ?? 0}',
        fontsize: 15,
      ),
    ];
   WidgetsBinding.instance.addPostFrameCallback((_) {
      DateTime.now().day == dayForcecast?.date.day ? Helpers.scrollToItem(_scrollController) : _scrollController.animateTo(
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
                        activeItem = index;
                        dayForcecast = DayForecast.fromJson(dailyWeatherForecast[index]);
                        if(index != nbrOfDAys - 1){
                          tomorrowForecast =  DayForecast.fromJson(widget.dailyWeatherForecast.firstWhere(
                          (map) =>
                              map['date'] ==
                              DateFormat('yyyy-MM-dd').format(
                                DateTime.parse(dailyWeatherForecast[index]["date"]).add(const Duration(days: 1))),
                          orElse: () => [],
                        ) ?? []) ;
                        }
                       
                      });

                    },  
                    child: DailyForecastsItem(
                      activeItem:activeItem ?? 0,
                        day:DateFormat('dd').format(DateTime.parse(dailyWeatherForecast[index]['date'])),
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
                decoration:const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -130,
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
                                            Row(
                                              children: [
                                             const   SizedBox(
                                                   width: 130,
                                                    height: 130,
                                                ),
                                        SizedBox(
                                          width: 150,
                                                    height: 135,
                                          child: Stack(
                                            alignment: Alignment.center,
                                           clipBehavior: Clip.none,
                                            children: [
                                                Positioned(
                                         left: 30,
                                          top: 90,
                                        child: Container(
                                          width: 90,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(.5),
                                            borderRadius: BorderRadius.circular(20)
                                          ),
                                        ),
                                      ),
                                              Positioned(
                                                top: -10,
                                                child: Column(                                     
                                                  children: [
                                                        
                                                                                    Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        dayForcecast!.maxTemperature.toStringAsFixed(0),
                                                                        style: TextStyle(
                                                                          fontSize: 80,
                                                                          fontWeight: FontWeight.bold,
                                                                          foreground: Paint()..shader = _constants.shader
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                          'o',
                                                                          style: TextStyle(
                                                                            fontSize: 25,
                                                                            fontWeight: FontWeight.bold,
                                                                            foreground: Paint()..shader = _constants.shader
                                                                          ),
                                                                        ),
                                                                      
                                                                    ],
                                                                  ),
                                                                     Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        dayForcecast!.minTemperature.toStringAsFixed(0),
                                                                        style: TextStyle(
                                                                          fontSize: 60,
                                                                          fontWeight: FontWeight.bold,
                                                                          foreground: Paint()..shader = _constants.shader
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                          'o',
                                                                          style: TextStyle(
                                                                            fontSize: 25,
                                                                            fontWeight: FontWeight.bold,
                                                                            foreground: Paint()..shader = _constants.shader
                                                                          ),
                                                                        ),
                                                                    
                                                                    ],
                                                                  ),
                                                                    Text(dayForcecast?.totalPrecipMM.toStringAsFixed(0) == '0' ? '' : 'Total Precipitation : ${dayForcecast?.totalPrecipMM.toStringAsFixed(0)} CM',
                                                                        style: TextStyle(
                                                                          fontSize: 15,
                                                                          fontWeight: FontWeight.bold,
                                                                          foreground: Paint()..shader = _constants.shader
                                                                        ),
                                                                      ),
                                                  ],
                                                
                                                ),
                                              ),
                                            ],
                                          ),
                                        )   
                                 
                 
                                              ],
                                            ),
                                           
                                            SizedBox(
                                              width: 150,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    dayForcecast!.currentWeatherCondition,
                                                  overflow: TextOverflow.ellipsis, 
                                                    maxLines: 2, 
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.w500,
                                                                     
                                                    
                                                    ),
                                                  ),
                                                  whatIsNow(),
                                                ],
                                              ),
                                            ),
                                          ],
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
                                physics: const BouncingScrollPhysics(),
                                itemCount: gridItems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: const EdgeInsets.all(3),
                                    child: gridItems[index]);
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
                                  activeItem = activeItem! + 1;
                                  print(activeItem);
                                  print(nbrOfDAys-1);
                                  if(activeItem! < nbrOfDAys - 1){
                                  dayForcecast = tomorrowForecast;
                              tomorrowForecast = DayForecast.fromJson(widget.dailyWeatherForecast.firstWhere(
                                (map) =>
                                    map['date'] ==
                                    DateFormat('yyyy-MM-dd').format(tomorrowForecast!.date.add(const Duration(days: 1))),
                                orElse: () => [],
                              ));
                                  }else{
                                    activeItem = 0;
                                    dayForcecast = DayForecast.fromJson(widget.dailyWeatherForecast.firstWhere(
                                      (map) => map['date'] == DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                      orElse: () => [],
                                    ));
                                    tomorrowForecast = DayForecast.fromJson(widget.dailyWeatherForecast.firstWhere(
                                      (map) =>
                                          map['date'] ==
                                          DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 1))),
                                      orElse: () => [],
                                    ));
                                  }
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
                               
                              ),
                              child: 
                              Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: 
                              [  
                                Positioned(
                                      top: -17,
                                      left: -50,                               
                                      child: Image.asset(
                                        'assets/images/sunny.png',
                                        width: 150,
                                      ),
                                    ),
                                Row(
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
                                    
                                  ],
                                ),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                        onPressed: () {},
                                        icon:const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        )))
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
  
  Widget whatIsNow() {
  bool isItToday = DateFormat('ddMMM, EEEE')
                                                          .format(dayForcecast!.date)
                                                          .toString()  ==  DateFormat('ddMMM, EEEE')
                                                          .format(DateTime.now())
                                                          .toString();

    if( isItToday && DateTime.now().hour > 17){

                                                            return const Text(
                                                    'Tonight',
                                                    style:  TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                            );
                                                          }else if(isItToday && DateTime.now().hour < 17){
                                                            return const Text(
                                                    'Today',
                                                    style:  TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                            );
                                                          } else {
                                                              return Text(
                                                    DateFormat('ddMMM, EEEE')
                                                          .format(dayForcecast!.date)
                                                          .toString() ,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                            );
                                                          }

      

  }
}
