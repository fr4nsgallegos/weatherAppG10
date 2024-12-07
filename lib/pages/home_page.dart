import 'package:flutter/material.dart';
import 'package:weatherappg10/widgets/search_box.dart';
import 'package:weatherappg10/widgets/weather_item.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2C2F31),
      appBar: AppBar(
        title: Text(
          "WeatherApp",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff2C2F31),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.location_on),
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          SearchBox(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            margin: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff6A99F7),
                  Color(0xff2E5FEC),
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                Text(
                  "Lima, Perú",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 24),
                Image.asset(
                  "assets/images/heavycloudy.png",
                  height: 100,
                ),
                SizedBox(height: 24),
                Text(
                  "23.9°",
                  style: TextStyle(color: Colors.white, fontSize: 100),
                ),
                Divider(
                  color: Colors.white,
                  thickness: 0.2,
                  indent: 16,
                  endIndent: 16,
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WeatherItem(),
                    WeatherItem(),
                    WeatherItem(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
