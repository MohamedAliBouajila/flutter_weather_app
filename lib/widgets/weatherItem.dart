import 'package:flutter/material.dart';
import 'package:weather_app/utils/constants.dart';

class WeatherItem extends StatelessWidget {
  final String value;
  final String unit;
  final String iconUrl;

  const WeatherItem({
    Key? key,
    required this.iconUrl,
    required this.unit,
    required this.value,
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
          child: Image.asset(
            iconUrl,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 8,),
        Text(
          '$value $unit',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    )
             ;
  }
}