import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/details_screen.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/helpers.dart';
import 'package:weather_app/widgets/hourlyforecastsItem.dart';
import 'package:weather_app/widgets/weatherItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Constants _constants = Constants();
  final TextEditingController _citySearchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String? location;
 
  @override
  Widget build(BuildContext context) {
    final ApiService apiService = Provider.of<ApiService>(context, listen: false);
    Weather weather = Provider.of<WeatherProvider>(context).weather;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

    Size size = MediaQuery.of(context).size;


    WidgetsBinding.instance.addPostFrameCallback((_) {
      Helpers.scrollToItem(_scrollController);
    });

    String weatherIcon =  weather.isDay == true ?
                       'assets/images/day/${weather.weatherIcon}':
                       'assets/images/night/${weather.weatherIcon}';

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        padding:const EdgeInsets.only(top: 50,left: 10,right: 10),
        color: _constants.primaryColor.withOpacity(.3),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              height: size.height * .7,
              width: size.width,
              decoration: BoxDecoration(
                gradient: _constants.linearGradientBlue,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _constants.primaryColor.withOpacity(.5),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(onPressed: (){
                        _citySearchController.clear();
                        showModalBottomSheet(context: context, builder: (context)=>SingleChildScrollView(
                         controller: ModalScrollController.of(context),
                         child: Container(
                          height: size.height * .7, 
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: Column( 
                            children: [
                              SizedBox(
                                width: 80,
                                child: Divider(
                                          color: _constants.primaryColor,
                                          thickness: 3,
                                      ),
                                      ),
                              const SizedBox(height: 10,),
                              TextField(
                                controller: _citySearchController,
                                onChanged: (searchValue) async{
                                    await apiService.getAndUpdateWeatherData(searchValue);
                                },
                                autofocus:true,
                                  decoration: InputDecoration(
                                                    prefixIcon: Icon(
                                                      Icons.search,
                                                      color: _constants
                                                          .primaryColor,
                                                    ),
                                                    suffixIcon: GestureDetector(
                                                      onTap: () =>
                                                          _citySearchController.clear(),
                                                      child: Icon(
                                                        Icons.close,
                                                        color: _constants
                                                            .primaryColor,
                                                      ),
                                                    ),
                                  hintText: 'Search for a city',
                                  hintStyle: TextStyle(
                                    color: _constants.primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: _constants.primaryColor,
                                      width: 2
                                    )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: _constants.primaryColor,
                                      width: 2
                                    )
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: _constants.primaryColor,
                                      width: 2
                                    )
                                  ),
                                ),
                              ),        
                            ],
                          ),
                         ),
                        ));
                      }, icon: const Icon(Icons.location_pin,color: Colors.white,), label: 
                     Text(weather.locationName ?? "No Location",style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                       ),

                    ],
                  ),
                  SizedBox(
                    height: 160,
                    child: 
                    Image.asset(
        weatherIcon,

        fit: BoxFit.contain,
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
      return Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.contain);
    },
      ),),
                  
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        weather.temperature.toString(),
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = _constants.shader
                        ),
                      ),
                      ),
                      Text(
                          'o',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = _constants.shader
                          ),
                        ),
                      
                    ],
                  ),
                  Text( weather.isDay == true ? "Today , ${weather.currentWeatherCondition} ":
                  "Tonight , ${weather.currentWeatherCondition} ",style: const TextStyle(
                    color:Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                   Text(
                    weather.currentDate ?? '',
                    style: const TextStyle(
                      color: Colors.white70,
                     fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                   ),
                 const Divider(
                    color: Colors.white38,
                    thickness: 2,
                  ),
Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WeatherItem(
                    icon: 'wind.png',
                    unit: 'km/h',
                    value: weather.windSpeed.toString(),
                  ), 
                  WeatherItem(
                    icon: 'humidity.png',
                    unit: '%',
                    value: weather.humidity.toString(),
                  ), 
                  WeatherItem(
                    icon: 'cloud.png',
                    unit: 'Okta',
                    value: weather.cloud.toString() ,
                  ), 
                  WeatherItem(
                    icon: 'pressure.png',
                    unit: 'mb',
                    value: weather.cloud.toString(),
                  ),
                      ],
                    ),
)
                   ]), 
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: size.height * .2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Today',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, 
                            MaterialPageRoute(builder: 
                          (context)=>DetailsScreen(dailyWeatherForecast: weather.dailyWeatherForecast ?? [], isDay: weather.isDay!)
                          
                          ));
                             },
                          child: Text('Forecasts',style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: _constants.primaryColor
                          ),),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),             
                   SizedBox(
                      height: 110,
                      child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: weather.hourlyWeatherForecast?.length,
                      controller: _scrollController,
                      itemBuilder:(BuildContext context,int index){
                          return HourlyForecastsItem(index: index,weatherPerHour: weather.hourlyWeatherForecast);
                      },
                   )
                     ),  
                ]
                ),
            )
        ]),
      ),

    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
