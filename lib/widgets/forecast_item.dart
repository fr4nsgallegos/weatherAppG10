import 'package:flutter/material.dart';

class ForecastItem extends StatelessWidget {
  String value;
  String hour;
  int isDay;

  ForecastItem({
    required this.value,
    required this.hour,
    required this.isDay,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
          color: Color(0xff404446),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 4,
              offset: Offset(4, 8),
            )
          ]),
      child: Column(
        children: [
          Text(
            hour,
            style: TextStyle(color: Colors.white38),
          ),
          SizedBox(height: 8),
          Image.asset(
            "assets/images/${isDay == 1 ? 'sunny' : 'overcast'}.png",
            height: 50,
          ),
          SizedBox(height: 8),
          Text(
            "$value°",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
