import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

const String ="ur api key here";

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double? temperature;
  String humidity = "";
  String pressure = "";
  String windSpeed = "";
  String weatherIcon = "☀️";
  String weatherDescription = "";
  LatLng? selectedLocation;

  Future<void> getWeatherData(double lat, double lon) async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (!mounted) return;

        setState(() {
          temperature = data["main"]["temp"];
          humidity = "${data["main"]["humidity"]}%";
          pressure = "${data["main"]["pressure"]} hPa";
          windSpeed = "${data["wind"]["speed"]} km/h";
          weatherDescription = data["weather"][0]["description"];
          weatherIcon = getWeatherIcon(data["weather"][0]["main"]);
        });
      }
    } catch (e) {
      print("Error fetching weather data: $e");
    }
  }

  String getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case "clear":
        return "☀️";
      case "clouds":
        return "☁️";
      case "rain":
        return "🌧️";
      case "thunderstorm":
        return "⛈️";
      case "snow":
        return "❄️";
      case "drizzle":
        return "🌦️";
      case "mist":
      case "fog":
        return "🌫️";
      default:
        return "🌡️";
    }
  }

  Future<void> getUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (!mounted) return;

      setState(() {
        selectedLocation = LatLng(position.latitude, position.longitude);
      });

      getWeatherData(position.latitude, position.longitude);
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Center(
        child: temperature == null
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      weatherIcon,
                      style: TextStyle(fontSize: 80),
                    ),
                    SizedBox(height: 10),
                    Text(
                      weatherDescription.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Temperature: ${temperature?.toStringAsFixed(1)}°C",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Humidity: $humidity",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Pressure: $pressure",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Wind Speed: $windSpeed",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
