import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherappg10/models/forecast_model.dart';
import 'package:weatherappg10/models/weather_model.dart';

class ApiService {
  Future<WeatherModel?> getWeatherInfo(double lat, double lang) async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=70866d7ade244a3c9ca20142230509&q=$lat,$lang&aqi=no");
    http.Response response = await http.get(url);
    print(response);
    print(response.statusCode);
    print(response.body);
    try {
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
    } catch (e) {
      print(e);
    }
  }

  Future<WeatherModel?> getWeatherInfoFromCity(String city) async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=70866d7ade244a3c9ca20142230509&q=$city&aqi=no");
    http.Response response = await http.get(url);
    print(response);
    print(response.statusCode);
    print(response.body);
    try {
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
    } catch (e) {
      print(e);
    }
  }

  Future<ForecastModel?> getForecastInfo(double lat, double lang) async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=70866d7ade244a3c9ca20142230509&q=$lat,$lang&days=1&aqi=no&alerts=no");
    // Uri url = Uri.parse(
    //     "http://api.weatherapi.com/v1/forecast.json?key=70866d7ade244a3c9ca20142230509&q=-14.10045931370631, -75.68985076365666&days=1&aqi=no&alerts=no");

    http.Response response = await http.get(url);
    // print(response);
    // print(response.statusCode);
    // print(response.body);
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        print(data);
        print("**************************");

        ForecastModel forecastModel = ForecastModel.fromJson(data);
        print("---------------------------");
        print(forecastModel.forecast);
        return forecastModel;
      }
      return null;
    } catch (e) {
      print(e);
    }
  }

  Future<ForecastModel?> getForecastInfoFromCity(String city) async {
    // Uri url = Uri.parse(
    //     "http://api.weatherapi.com/v1/forecast.json?key=70866d7ade244a3c9ca20142230509&q=$lat,$lang&days=1&aqi=no&alerts=no");
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=70866d7ade244a3c9ca20142230509&q=$city&days=1&aqi=no&alerts=no");

    http.Response response = await http.get(url);
    // print(response);
    // print(response.statusCode);
    // print(response.body);
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        print(data);
        print("**************************");

        ForecastModel forecastModel = ForecastModel.fromJson(data);
        print("---------------------------");
        print(forecastModel.forecast);
        return forecastModel;
      }
      return null;
    } catch (e) {
      print(e);
    }
  }
}
