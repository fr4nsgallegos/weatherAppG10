import 'package:flutter/material.dart';
import 'package:weatherappg10/models/weather_model.dart';
import 'package:weatherappg10/services/api_service.dart';
import 'package:weatherappg10/widgets/search_box.dart';
import 'package:weatherappg10/widgets/weather_item.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherModel;

  getDataLocation() async {
    weatherModel = await ApiService().getInfo();
    setState(() {});
  }

  @override
  void initState() {
    getDataLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        ApiService().getInfo();
      }),
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
          weatherModel == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
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
                        "${weatherModel!.location.name}, ${weatherModel!.location.country}",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 24),
                      Image.asset(
                        "assets/images/heavycloudy.png",
                        height: 100,
                      ),
                      SizedBox(height: 24),
                      Text(
                        "${weatherModel!.current.tempC}°",
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
