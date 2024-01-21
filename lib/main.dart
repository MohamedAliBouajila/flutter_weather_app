import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/homeScreen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/screens/splashScreen.dart';
import 'package:weather_app/services/apiService.dart';



void main() async {
  await dotenv.load();
  // Create an instance of WeatherProvider
  WeatherProvider weatherProvider = WeatherProvider();
  // Create an instance of ApiService and pass the WeatherProvider to it
  ApiService apiService = ApiService(weatherProvider);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: weatherProvider),
        Provider<ApiService>.value(value: apiService),
      ],
      child:const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService(Provider.of<WeatherProvider>(context, listen: false));

    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(   
        useMaterial3: true,
      ),
      home: SplashScreen(apiService: apiService),
    );
  }
}
