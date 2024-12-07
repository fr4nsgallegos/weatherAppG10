import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future getInfo() async {
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

      print(data["location"]);
    }
  }
}
