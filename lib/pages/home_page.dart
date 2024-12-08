import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherappg10/models/forecast_model.dart';
import 'package:weatherappg10/models/weather_model.dart';
import 'package:weatherappg10/services/api_service.dart';
import 'package:weatherappg10/widgets/forecast_item.dart';
import 'package:weatherappg10/widgets/search_box.dart';
import 'package:weatherappg10/widgets/weather_item.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherModel;
  ForecastModel? forecastModel;
  final formkey = GlobalKey<FormState>();
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
    // weatherModel = await ApiService()
    //     .getWeatherInfo(position.latitude, position.longitude);
    forecastModel = await ApiService()
        .getForecastInfo(position.latitude, position.longitude);
    print("---------------------");
    print(forecastModel);
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
        ApiService().getForecastInfo(-14.10045931370631, -75.68985076365666);
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
            onPressed: () {
              getDataLocation();
              ciudadController.clear();
              setState(() {});
            },
            icon: Icon(Icons.location_on),
            color: Colors.white,
          ),
        ],
      ),
      body: Form(
        key: formkey,
        child: forecastModel == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  SearchBox(
                    controller: ciudadController,
                    function: () async {
                      if (formkey.currentState!.validate()) {
                        // weatherModel = await ApiService()
                        //     .getWeatherInfoFromCity(ciudadController.text);
                        forecastModel = await ApiService()
                            .getForecastInfoFromCity(ciudadController.text);
                        FocusScope.of(context).unfocus();
                        ciudadController.clear();
                        setState(() {});
                      }
                    },
                  ),
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
                          "${forecastModel!.location.name}, ${forecastModel!.location.country}",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(height: 24),
                        Image.asset(
                          "assets/images/heavycloudy.png",
                          height: 100,
                        ),
                        SizedBox(height: 24),
                        Text(
                          "${forecastModel!.current.tempC}°",
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
                              value: forecastModel!.current.windKph.toString(),
                              unit: "km/h",
                              imagePath: "windspeed",
                            ),
                            WeatherItem(
                              value: forecastModel!.current.humidity.toString(),
                              unit: "%",
                              imagePath: "humidity",
                            ),
                            WeatherItem(
                              value: forecastModel!.current.cloud.toString(),
                              unit: "%",
                              imagePath: "cloud",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          forecastModel!.forecast.forecastday[0].hour.length,
                          (index) => ForecastItem(
                            hour: forecastModel!
                                .forecast.forecastday[0].hour[index].time
                                .toString()
                                .substring(11, 16),
                            isDay: forecastModel!
                                .forecast.forecastday[0].hour[index].isDay,
                            value: forecastModel!
                                .forecast.forecastday[0].hour[index].tempC
                                .toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
