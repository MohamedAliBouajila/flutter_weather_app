import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/dayforecast.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/helpers.dart';
import 'package:weather_app/widgets/dailyforecastsItem.dart';
import 'package:weather_app/widgets/hourlyforecastsItem.dart';
import 'package:weather_app/widgets/weatherItem.dart';

class DetailsScreen extends StatefulWidget {
  final List<dynamic> dailyWeatherForecast;
  final bool isDay;

  const DetailsScreen(
      {Key? key, required this.dailyWeatherForecast, required this.isDay})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final Constants _constants = Constants();
  final ScrollController _scrollController = ScrollController();
  DayForecast? dayForcecast;
  DayForecast? tomorrowForecast;
  int nbrOfDAys = 0;
  int? activeItem;

  @override
  void initState() {
    activeItem = widget.dailyWeatherForecast.indexWhere(
      (map) => map['date'] == DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
    nbrOfDAys = widget.dailyWeatherForecast.length;
    dayForcecast = DayForecast.fromJson(widget.dailyWeatherForecast.firstWhere(
      (map) => map['date'] == DateFormat('yyyy-MM-dd').format(DateTime.now()),
      orElse: () => [],
    ));
    tomorrowForecast =
        DayForecast.fromJson(widget.dailyWeatherForecast.firstWhere(
      (map) =>
          map['date'] ==
          DateFormat('yyyy-MM-dd')
              .format(DateTime.now().add(const Duration(days: 1))),
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
      DateTime.now().day == dayForcecast?.date.day
          ? Helpers.scrollToItem(_scrollController)
          : _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
    });

    void incrementDate() {
      setState(() {
        activeItem = activeItem! + 1;
        if (activeItem! < nbrOfDAys - 1) {
          dayForcecast = tomorrowForecast;
          tomorrowForecast =
              DayForecast.fromJson(dailyWeatherForecast.firstWhere(
            (map) =>
                map['date'] ==
                DateFormat('yyyy-MM-dd').format(
                    tomorrowForecast!.date.add(const Duration(days: 1))),
            orElse: () => [],
          ));
        } else if (activeItem == nbrOfDAys - 1) {
          dayForcecast = tomorrowForecast;
          tomorrowForecast =
              DayForecast.fromJson(dailyWeatherForecast.firstWhere(
            (map) =>
                map['date'] == DateFormat('yyyy-MM-dd').format(DateTime.now()),
            orElse: () => [],
          ));
        } else {
          activeItem = 0;
          dayForcecast = DayForecast.fromJson(dailyWeatherForecast.firstWhere(
            (map) =>
                map['date'] == DateFormat('yyyy-MM-dd').format(DateTime.now()),
            orElse: () => [],
          ));
          tomorrowForecast =
              DayForecast.fromJson(dailyWeatherForecast.firstWhere(
            (map) =>
                map['date'] ==
                DateFormat('yyyy-MM-dd')
                    .format(DateTime.now().add(const Duration(days: 1))),
            orElse: () => [],
          ));
        }
      });
    }

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
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          activeItem = index;
                          dayForcecast = DayForecast.fromJson(
                              dailyWeatherForecast[index]);
                          if (index != nbrOfDAys - 1) {
                            tomorrowForecast = DayForecast.fromJson(
                                widget.dailyWeatherForecast.firstWhere(
                                      (map) =>
                                          map['date'] ==
                                          DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(
                                                      dailyWeatherForecast[
                                                          index]["date"])
                                                  .add(const Duration(
                                                      days: 1))),
                                      orElse: () => [],
                                    ) ??
                                    []);
                          }
                        });
                      },
                      child: DailyForecastsItem(
                          activeItem: activeItem ?? 0,
                          day: DateFormat('dd').format(DateTime.parse(
                              dailyWeatherForecast[index]['date'])),
                          index: index,
                          weather: DayForecast.fromJson(
                              dailyWeatherForecast[index])),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: size.height * .59,
                width: size.width,
                decoration: const BoxDecoration(
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
                        height: size.height * .90,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
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
                                              'assets/images/day/${dayForcecast!.weatherIcon}',
                                              width: 180,
                                              errorBuilder: (BuildContext
                                                      context,
                                                  Object error,
                                                  StackTrace? stackTrace) {
                                                return Image.asset(
                                                  'assets/images/logo.png',
                                                  width: 180,
                                                );
                                              },
                                            )),
                                        Positioned(
                                          top: 0,
                                          right: 30,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Text(
                                                    dayForcecast!
                                                        .maxTemperature
                                                        .toStringAsFixed(0),
                                                    style: TextStyle(
                                                        fontSize: 80,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        foreground: Paint()
                                                          ..shader =
                                                              _constants
                                                                  .shader),
                                                  ),
                                                  Text(
                                                    'o',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        foreground: Paint()
                                                          ..shader =
                                                              _constants
                                                                  .shader),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Text(
                                                    dayForcecast!
                                                        .minTemperature
                                                        .toStringAsFixed(0),
                                                    style: TextStyle(
                                                        fontSize: 60,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        foreground: Paint()
                                                          ..shader =
                                                              _constants
                                                                  .shader),
                                                  ),
                                                  Text(
                                                    'o',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        foreground: Paint()
                                                          ..shader =
                                                              _constants
                                                                  .shader),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    // weather condition Icon and text with date
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          width: 130,
                                                          height: 130,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                dayForcecast!
                                                                    .currentWeatherCondition,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines:
                                                                    2,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      17,
                                                                  fontWeight:
                                                                      FontWeight.w500,
                                                                ),
                                                              ),
                                                              Text(
                                                                DateFormat(
                                                                        'ddMMM, EEEE')
                                                                    .format(
                                                                        dayForcecast!.date)
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // weather top and min temperature
                                                    const SizedBox(
                                                      width: 100,
                                                      height: 200,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  dayForcecast?.totalPrecipMM
                                              .toStringAsFixed(0) ==
                                          '0'
                                      ? const SizedBox.shrink()
                                      : Text(
                                          'Total Precipitation : ${dayForcecast?.totalPrecipMM.toStringAsFixed(0)} CM',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              foreground: Paint()
                                                ..shader =
                                                    _constants.shader),
                                        ),
                                  SizedBox(
                                    height: 110,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      physics:
                                          const BouncingScrollPhysics(),
                                      itemCount: gridItems.length,
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        return Container(
                                            padding:
                                                const EdgeInsets.all(3),
                                            child: gridItems[index]);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15),
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
                                        isFistDay: DateTime.now().day ==
                                            dayForcecast?.date.day,
                                        weatherPerHour: dayForcecast
                                            ?.hourlyWeatherForecast,
                                      );
                                    },
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                incrementDate();
                              },
                              child: Container(
                                height: 120,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                decoration: BoxDecoration(
                                  gradient: _constants.linearGradientBlue,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                child: Stack(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                          top: -17,
                                          left: -50,
                                          child: Image.asset(
                                            'assets/images/day/${tomorrowForecast!.weatherIcon}',
                                            width: 150,
                                            errorBuilder: (BuildContext
                                                    context,
                                                Object error,
                                                StackTrace? stackTrace) {
                                              return Image.asset(
                                                'assets/images/logo.png',
                                                width: 150,
                                              );
                                            },
                                          )),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 100,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                tomorrowForecast!
                                                    .currentWeatherCondition,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 21,
                                                  fontWeight:
                                                      FontWeight.w500,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    DateFormat('ddMMM, ')
                                                        .format(
                                                            tomorrowForecast!
                                                                .date)
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    DateFormat('EEEE')
                                                        .format(
                                                            tomorrowForecast!
                                                                .date)
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '${tomorrowForecast!.minTemperature.toString()}/${tomorrowForecast!.maxTemperature.toString()} °',
                                                style: const TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 19,
                                                  fontWeight:
                                                      FontWeight.w400,
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
                                              icon: const Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.white,
                                              )))
                                    ]),
                              ),
                            )
                          ],
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
