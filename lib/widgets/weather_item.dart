import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/windspeed.png",
          height: 50,
        ),
        SizedBox(height: 16),
        Text(
          "18 km/h",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
