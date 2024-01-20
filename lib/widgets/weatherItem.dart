import 'package:flutter/material.dart';
import 'package:weather_app/utils/constants.dart';

class WeatherItem extends StatelessWidget {
  final String value;
  final String unit;
  final String icon;
  final double fontsize;

  const WeatherItem({
    Key? key,
    required this.icon,
    required this.unit,
    required this.value,
    this.fontsize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Constants constants = Constants();
    return  Column(
      children: [
        Container(
          padding:const EdgeInsets.all(10),
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: constants.primaryColor.withOpacity(.3),
            borderRadius: BorderRadius.circular(20)
          ),
          child: 
           Image.asset(
             'assets/images/$icon',
            fit: BoxFit.contain,
    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
   
      return Image.asset(
        'assets/images/logo.png',
              
            fit: BoxFit.contain,
      );
    },
  )
        ),
        const SizedBox(height: 8,),
        Text(
          '$value $unit',
          style: TextStyle(
            color: Colors.white70,
            fontSize: fontsize,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    )
             ;
  }
}