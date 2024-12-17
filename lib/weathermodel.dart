import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CityValidator(),
    );
  }
}

class CityValidator extends StatefulWidget {
  @override
  _CityValidatorState createState() => _CityValidatorState();
}

class _CityValidatorState extends State<CityValidator> {
  final TextEditingController _controller = TextEditingController();
  String _statusMessage = '';
  bool _isValidCity = false;
  ApiResponse? _apiResponse;

  // Mock API endpoint for validating a city
  Future<void> _getCityData(String cityName) async {
    final response = await http.get(Uri.parse('https://api.example.com/validate-city?name=$cityName'));

    if (response.statusCode == 200) {
      // Assuming the API returns a valid response structure
      var data = jsonDecode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(data);

      if (apiResponse.location == null || apiResponse.current == null) {
        setState(() {
          _statusMessage = 'City "$cityName" not found or invalid.';
          _isValidCity = false;
          _apiResponse = null;
        });
      } else {
        setState(() {
          _statusMessage = 'City "$cityName" is valid!';
          _isValidCity = true;
          _apiResponse = apiResponse;
        });
      }
    } else {
      // Handle API error response
      setState(() {
        _statusMessage = 'Failed to fetch city data. Please try again.';
        _isValidCity = false;
        _apiResponse = null;
      });
    }
  }

  // Function to validate the city
  void _validateCity() async {
    String city = _controller.text.trim();

    if (city.isEmpty) {
      setState(() {
        _statusMessage = 'Please enter a city name.';
        _isValidCity = false;
        _apiResponse = null;
      });
      return;
    }

    // Call the API to check if the city is valid
    await _getCityData(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City Validator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validateCity,
              child: Text('Validate City'),
            ),
            SizedBox(height: 20),
            Text(
              _statusMessage,
              style: TextStyle(
                fontSize: 18,
                color: _isValidCity ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 20),
            _isValidCity && _apiResponse != null
                ? Column(
              children: [
                Text('City: ${_apiResponse!.location!.name}, ${_apiResponse!.location!.country}'),
                Text('Temperature: ${_apiResponse!.current!.tempC}°C'),
                Text('Condition: ${_apiResponse!.current!.condition!.text}'),
              ],
            )
                : Container(), // Show nothing if not valid
          ],
        ),
      ),
    );
  }
}

class ApiResponse {
  Location? location;
  Current? current;

  ApiResponse({this.location, this.current});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    current = json['current'] != null
        ? Current.fromJson(json['current'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
    return data;
  }
}

class Location {
  String? name;
  String? country;
  String? localtime;

  Location({this.name, this.country, this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['country'] = this.country;
    data['localtime'] = this.localtime;
    return data;
  }
}

class Current {
  double? tempC;
  int? isDay;
  Condition? condition;
  double? windKph;
  double? precipMm;
  int? humidity;
  double? uv;

  Current({
    this.tempC,
    this.isDay,
    this.condition,
    this.windKph,
    this.precipMm,
    this.humidity,
    this.uv,
  });

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    precipMm = json['precip_mm'];
    humidity = json['humidity'];
    uv = json['uv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['temp_c'] = this.tempC;
    data['is_day'] = this.isDay;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    data['wind_kph'] = this.windKph;
    data['precip_mm'] = this.precipMm;
    data['humidity'] = this.humidity;
    data['uv'] = this.uv;
    return data;
  }
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['text'] = this.text;
    data['icon'] = this.icon;
    data['code'] = this.code;
    return data;
  }
}
