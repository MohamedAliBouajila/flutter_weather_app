import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/utils/constants.dart';

class SplashScreen extends StatelessWidget {
  final Constants _constants = Constants();
  final ApiService apiService;

  SplashScreen({Key? key, required this.apiService}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        // Replace fetchData with your actual data fetching function
        future: apiService.getAndUpdateWeatherData("Tunisia"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Data fetched successfully, navigate to home screen
            return const HomeScreen();
          } else if (snapshot.hasError) {
            // Handle error
            return Text('Error fetching data');
          } else {
            // Still fetching data, show a loading indicator
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: _constants.linearGradientBlue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', width: 100, height: 100),
                  const SizedBox(height: 20),
                  const Text('Weather', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  const CircularProgressIndicator(color: Colors.white),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
