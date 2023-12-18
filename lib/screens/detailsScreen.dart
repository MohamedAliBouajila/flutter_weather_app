import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/dayforecast.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/widgets/dailyForecastsItem.dart';
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

  @override
  void initState() {
    dayForcecast = DayForecast.fromJson(widget.dailyWeatherForecast.firstWhere(
      (map) =>
          map['date'] == DateFormat('yyyy-MM-dd').format(DateTime.now()),
      orElse: () => null,
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
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
              height: 110,
              width: size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: dailyWeatherForecast.length,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return DailyForecastsItem(
                      index: index,
                      weather: DayForecast.fromJson(dailyWeatherForecast[index]));
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
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
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: gridItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return gridItems[index];
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 150,
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
