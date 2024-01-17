import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/screens/homeScreen.dart';
import 'package:weather_app/services/apiService.dart';
import 'package:weather_app/utils/constants.dart';

class SplashScreen extends StatelessWidget {
  final Constants _constants = Constants();
  final ApiService apiService = ApiService();

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: _constants.linearGradientBlue,
        ),
      child: Scaffold(
        body: 
         FutureBuilder(
          // Replace fetchData with your actual data fetching function
          future: apiService.getWeatherData("Tunisia"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Data fetched successfully, navigate to home screen
              return ChangeNotifierProvider(
                create: (context) => snapshot.data as Weather,
                child: HomeScreen(),
              );
            } else if (snapshot.hasError) {
              // Handle error
              return Text('Error fetching data');
            } else {
              // Still fetching data, show a loading indicator
              return  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 100, height: 100),
              const SizedBox(height: 20),
              const Text('Weather', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              const CircularProgressIndicator(color: Colors.white),
            ],
          );
            }
          },
        ),
      ),
    );
  }
}