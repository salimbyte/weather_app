import 'dart:convert';

import 'package:weather_app/constants.dart';
import 'package:weather_app/weathermodel.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

  Future<ApiResponse> getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apiKey&q=$location";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return ApiResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        if (errorData["error"]["code"] == 1006) {
          throw Exception("No matching location found");
        }
        throw Exception("Failed to load weather");
      } else {
        throw Exception("Failed to load weather");
      }
    } catch (e) {
      throw Exception("Failed to load weather");
    }
  }
}

