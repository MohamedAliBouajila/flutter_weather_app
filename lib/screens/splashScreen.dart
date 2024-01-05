import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather_app/utils/constants.dart';

class SplashScreen extends StatefulWidget {
   final int duration;
   final Widget navigateAfterDuration;

  const SplashScreen({
    Key? key, 
    required this.duration,
    required this.navigateAfterDuration,
  })  : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final Constants _constants = Constants();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: widget.duration), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => widget.navigateAfterDuration),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
      ),
    );
  }
}