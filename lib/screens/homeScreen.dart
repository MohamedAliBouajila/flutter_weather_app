import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/services/apiService.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/widgets/weatherItem.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  final Constants _constants = Constants();
  final TextEditingController _citySearchController = TextEditingController();
  
  String location = 'Tunisia';
 
  Weather? weather;

  Future<void> getWeatherData(String location) async {
    var data = await apiService.getWeatherData(location.toLowerCase().trim());
    setState(() {
      weather = data;
    });
  }

  @override
  void initState() {
    getWeatherData(location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

    Size size = MediaQuery.of(context).size;
   
    if (weather == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
                                onChanged: (searchValue){
                                  getWeatherData(searchValue);
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
                      }, icon: Icon(Icons.location_pin,color: Colors.white,), label: 
                     Text(weather?.locationName ?? "No Location",style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                       ),

                    ],
                  ),
                  SizedBox(
                    height: 160,
                    child: Image.asset(
                      'assets/images/sunny.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '${weather?.temperature.toString() ?? 0}',
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
                  Text(weather?.currentWeatherCondition ?? " ",style: const TextStyle(
                    color:Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                   Text(
                    '${weather?.currentDate ?? " "}',
                    style: TextStyle(
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
                    iconUrl: 'assets/images/sunny.png',
                    unit: 'km/h',
                    value: '${weather?.windSpeed.toString() ?? 0}',
                  ), 
                  WeatherItem(
                    iconUrl: 'assets/images/sunny.png',
                    unit: '%',
                    value: '${weather?.humidity.toString() ?? 0}',
                  ), 
                  WeatherItem(
                    iconUrl: 'assets/images/sunny.png',
                    unit: 'Okta',
                    value: '${weather?.cloud.toString() ?? 0}',
                  ), 
                  WeatherItem(
                    iconUrl: 'assets/images/sunny.png',
                    unit: 'mb',
                    value: '${weather?.cloud.toString() ?? 0}',
                  ),
                      ],
                    ),
)
                   ]), 
            ),
        ]),
      ),
    );
  }
}
