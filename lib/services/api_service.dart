import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherappg10/models/weather_model.dart';

class ApiService {
  Future<WeatherModel?> getInfo() async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=70866d7ade244a3c9ca20142230509&q=Lima&aqi=no");
    http.Response response = await http.get(url);
    print(response);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      print("------------------------");
      print(data);
      print("------------------------");
      WeatherModel weatherModel = WeatherModel.fromJson(data);
      print(weatherModel);
      print(weatherModel.location.name);
      return weatherModel;
    }
    return null;
  }
}