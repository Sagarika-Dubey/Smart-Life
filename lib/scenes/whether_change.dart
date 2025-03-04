import 'package:flutter/material.dart';

class WeatherChangeScreen extends StatelessWidget {
  final List<String> weatherOptions = [
    "Temperature",
    "Humidity",
    "Weather",
    "Sunset/Sunrise",
    "Wind Speed",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("When weather changes"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: weatherOptions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(weatherOptions[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailScreen(title: weatherOptions[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String title;

  DetailScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text("Details about $title will be shown here.",
            style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
