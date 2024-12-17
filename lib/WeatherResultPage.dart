import 'package:flutter/material.dart';
import 'package:weather_app/api.dart';
import 'package:weather_app/weathermodel.dart';

class WeatherDetailPage extends StatefulWidget {
  final String location;
  const WeatherDetailPage({super.key, required this.location});

  @override
  State<WeatherDetailPage> createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {
  ApiResponse? response;
  bool inProgress = false;
  String message = "Loading weather data...";
  Color backgroundColor = Colors.white;
  Color textColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _getWeatherData(widget.location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: SafeArea(
        child: inProgress
            ? const Center(child: CircularProgressIndicator())
            : response != null
            ? _buildWeatherContent()
            : Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Text(
              message,
              style: TextStyle(fontSize: 17, color: textColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            size: 40,
            color: textColor, // Dynamic color applied to the location icon
          ),
          const SizedBox(height: 5),
          Text(
            response?.location?.name ?? "",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 5),
          Text(
            response?.location?.country?.split(" ").last ?? "",
            style: TextStyle(fontSize: 24, color: textColor.withOpacity(0.7)),
          ),
          const SizedBox(height: 10),
          Image.network(
            "https:${response?.current?.condition?.icon}".replaceAll("64x64", "128x128"),
            scale: 0.7,
          ),
          const SizedBox(height: 0),
          Text(
            response?.current?.condition?.text ?? "",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: textColor),
          ),
          const SizedBox(height: 10),
          Text(
            "${response?.current?.tempC.toString() ?? ""} °C",
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 5),
          _buildDetailsBox(),
        ],
      ),
    );
  }

  Widget _buildDetailsBox() {
    return Card(
      color: backgroundColor.withOpacity(0.8),
      elevation: 0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _dataAndTitleWidget("Humidity", response?.current?.humidity?.toString() ?? ""),
              _dataAndTitleWidget("Wind Speed", "${response?.current?.windKph?.toString() ?? ""} km/h"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _dataAndTitleWidget("UV", response?.current?.uv?.toString() ?? ""),
              _dataAndTitleWidget("Precipitation", "${response?.current?.precipMm?.toString() ?? ""} mm"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _dataAndTitleWidget("Local Time", response?.location?.localtime?.split(" ").last ?? ""),
              _dataAndTitleWidget("Local Date", response?.location?.localtime?.split(" ").first ?? ""),
            ],
          )
        ],
      ),
    );
  }

  Widget _dataAndTitleWidget(String title, String data) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            data,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: textColor.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  _getWeatherData(String location) async {
    setState(() {
      inProgress = true;
    });

    try {
      response = await WeatherApi().getCurrentWeather(location);

      if (response == null || response?.location?.name == null) {
        setState(() {
          message = "Invalid location. Please check the location name.";
          response = null;
        });
        return;
      }

      // Determine if it's day or night using the local time
      if (response?.location?.localtime != null) {
        String localtime = response!.location!.localtime!;
        int hour = int.parse(localtime.split(" ").last.split(":").first);

        if (hour >= 6 && hour <= 18) {
          // Daytime
          backgroundColor = Colors.white;
          textColor = Colors.black;
        } else {
          // Nighttime
          backgroundColor = Colors.black;
          textColor = Colors.white;
        }
      }
    } catch (e) {
      setState(() {
        message = "Failed to get weather data. Please try again later.";
        response = null;
      });
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }
}
