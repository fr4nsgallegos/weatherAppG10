import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  TextEditingController ciudadController = TextEditingController();
  Future<Position> getLocation() async {
    bool _serviceEnabled;
    LocationPermission _permission;

    _serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!_serviceEnabled) {
      return Future.error("Servicios de geolocalización deshabilitados ");
    }

    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        return Future.error("Los permisos han sido denegados");
      }
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getDataLocation() async {
    Position position = await getLocation();

    print(position);
    weatherModel = await ApiService()
        .getWeatherInfo(position.latitude, position.longitude);
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBox(
              controller: ciudadController,
              function: () async {
                weatherModel = await ApiService()
                    .getWeatherInfoFromCity(ciudadController.text);
                setState(() {});
              },
            ),
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
                            WeatherItem(
                              value: weatherModel!.current.windKph.toString(),
                              unit: "km/h",
                              imagePath: "windspeed",
                            ),
                            WeatherItem(
                              value: weatherModel!.current.humidity.toString(),
                              unit: "%",
                              imagePath: "humidity",
                            ),
                            WeatherItem(
                              value: weatherModel!.current.cloud.toString(),
                              unit: "%",
                              imagePath: "cloud",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
