import 'package:flutter/material.dart';
import 'dart:math';

// Shared Alert Creation Mixin
mixin AlertCreationMixin<T> {
  void showAlertCreatedSnackBar(BuildContext context, T alertDetails) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Alert created successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

// Humidity Alert Screen
class HumidityScreen extends StatefulWidget {
  @override
  _HumidityScreenState createState() => _HumidityScreenState();
}

class _HumidityScreenState extends State<HumidityScreen>
    with AlertCreationMixin {
  final TextEditingController _cityController = TextEditingController();
  double _humidity = 50.0;
  String _comparison = "<";
  bool _isNextEnabled = false;

  @override
  void initState() {
    super.initState();
    _cityController.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      _isNextEnabled = _cityController.text.isNotEmpty;
    });
  }

  void _handleNext() {
    if (_isNextEnabled) {
      final humidityAlert = {
        'city': _cityController.text,
        'humidity': _humidity,
        'comparisonOperator': _comparison,
      };

      showAlertCreatedSnackBar(context, humidityAlert);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Humidity Alert")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select City", style: TextStyle(fontSize: 18)),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter city name",
              ),
            ),
            SizedBox(height: 20),
            Text("Comparison Operator", style: TextStyle(fontSize: 18)),
            ToggleButtons(
              isSelected: [
                _comparison == "<",
                _comparison == "=",
                _comparison == ">",
              ],
              onPressed: (int index) {
                setState(() {
                  _comparison = ["<", "=", ">"][index];
                });
              },
              children: [
                Padding(padding: EdgeInsets.all(8.0), child: Text("<")),
                Padding(padding: EdgeInsets.all(8.0), child: Text("=")),
                Padding(padding: EdgeInsets.all(8.0), child: Text(">")),
              ],
            ),
            SizedBox(height: 20),
            Text("Humidity: ${_humidity.toStringAsFixed(1)}%",
                style: TextStyle(fontSize: 18)),
            Slider(
              min: 0,
              max: 100,
              divisions: 100,
              value: _humidity,
              label: _humidity.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _humidity = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isNextEnabled ? _handleNext : null,
              child: Text("Create Humidity Alert"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Weather Condition Screen
class WeatherConditionScreen extends StatefulWidget {
  @override
  _WeatherConditionScreenState createState() => _WeatherConditionScreenState();
}

class _WeatherConditionScreenState extends State<WeatherConditionScreen>
    with AlertCreationMixin {
  final TextEditingController _cityController = TextEditingController();
  final List<String> _weatherConditions = [
    'Sunny',
    'Cloudy',
    'Rainy',
    'Snowy',
    'Stormy',
    'Windy',
    'Foggy',
    'Clear',
    'Partly Cloudy'
  ];
  String? _selectedCondition;
  bool _isNextEnabled = false;

  @override
  void initState() {
    super.initState();
    _cityController.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      _isNextEnabled =
          _cityController.text.isNotEmpty && _selectedCondition != null;
    });
  }

  void _handleNext() {
    if (_isNextEnabled) {
      final weatherAlert = {
        'city': _cityController.text,
        'condition': _selectedCondition,
      };

      showAlertCreatedSnackBar(context, weatherAlert);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather Condition Alert")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select City", style: TextStyle(fontSize: 18)),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter city name",
              ),
            ),
            SizedBox(height: 20),
            Text("Select Weather Condition", style: TextStyle(fontSize: 18)),
            DropdownButtonFormField<String>(
              value: _selectedCondition,
              hint: Text("Choose a condition"),
              items: _weatherConditions.map((condition) {
                return DropdownMenuItem(
                  value: condition,
                  child: Text(condition),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCondition = value;
                  _validateInputs();
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isNextEnabled ? _handleNext : null,
              child: Text("Create Weather Condition Alert"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Sunset/Sunrise Screen
class SunriseSunsetScreen extends StatefulWidget {
  @override
  _SunriseSunsetScreenState createState() => _SunriseSunsetScreenState();
}

class _SunriseSunsetScreenState extends State<SunriseSunsetScreen>
    with AlertCreationMixin {
  final TextEditingController _cityController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _sunEvent = 'Sunrise';
  bool _isNextEnabled = false;

  @override
  void initState() {
    super.initState();
    _cityController.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      _isNextEnabled = _cityController.text.isNotEmpty;
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _handleNext() {
    if (_isNextEnabled) {
      final sunAlert = {
        'city': _cityController.text,
        'time': _selectedTime.format(context),
        'event': _sunEvent,
      };

      showAlertCreatedSnackBar(context, sunAlert);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sunrise/Sunset Alert")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select City", style: TextStyle(fontSize: 18)),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter city name",
              ),
            ),
            SizedBox(height: 20),
            Text("Select Sun Event", style: TextStyle(fontSize: 18)),
            DropdownButtonFormField<String>(
              value: _sunEvent,
              items: ['Sunrise', 'Sunset'].map((event) {
                return DropdownMenuItem(
                  value: event,
                  child: Text(event),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _sunEvent = value!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text("Select Time", style: TextStyle(fontSize: 18)),
            ListTile(
              title: Text(_selectedTime.format(context)),
              trailing: Icon(Icons.access_time),
              onTap: () => _selectTime(context),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isNextEnabled ? _handleNext : null,
              child: Text("Create Sunrise/Sunset Alert"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Wind Speed Screen
class WindSpeedScreen extends StatefulWidget {
  @override
  _WindSpeedScreenState createState() => _WindSpeedScreenState();
}

class _WindSpeedScreenState extends State<WindSpeedScreen>
    with AlertCreationMixin {
  final TextEditingController _cityController = TextEditingController();
  double _windSpeed = 10.0;
  String _comparison = "<";
  final List<String> _windDirections = [
    'N',
    'NE',
    'E',
    'SE',
    'S',
    'SW',
    'W',
    'NW'
  ];
  String? _selectedDirection;
  bool _isNextEnabled = false;

  @override
  void initState() {
    super.initState();
    _cityController.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      _isNextEnabled = _cityController.text.isNotEmpty;
    });
  }

  void _handleNext() {
    if (_isNextEnabled) {
      final windAlert = {
        'city': _cityController.text,
        'windSpeed': _windSpeed,
        'comparisonOperator': _comparison,
        'direction': _selectedDirection,
      };

      showAlertCreatedSnackBar(context, windAlert);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wind Speed Alert")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select City", style: TextStyle(fontSize: 18)),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter city name",
              ),
            ),
            SizedBox(height: 20),
            Text("Comparison Operator", style: TextStyle(fontSize: 18)),
            ToggleButtons(
              isSelected: [
                _comparison == "<",
                _comparison == "=",
                _comparison == ">",
              ],
              onPressed: (int index) {
                setState(() {
                  _comparison = ["<", "=", ">"][index];
                });
              },
              children: [
                Padding(padding: EdgeInsets.all(8.0), child: Text("<")),
                Padding(padding: EdgeInsets.all(8.0), child: Text("=")),
                Padding(padding: EdgeInsets.all(8.0), child: Text(">")),
              ],
            ),
            SizedBox(height: 20),
            Text("Wind Speed: ${_windSpeed.toStringAsFixed(1)} km/h",
                style: TextStyle(fontSize: 18)),
            Slider(
              min: 0,
              max: 100,
              divisions: 100,
              value: _windSpeed,
              label: _windSpeed.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _windSpeed = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text("Select Wind Direction", style: TextStyle(fontSize: 18)),
            Wrap(
              spacing: 8,
              children: _windDirections.map((direction) {
                return ChoiceChip(
                  label: Text(direction),
                  selected: _selectedDirection == direction,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedDirection = selected ? direction : null;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isNextEnabled ? _handleNext : null,
              child: Text("Create Wind Speed Alert"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
mixin AlertCreationMixin<T> {
  void showAlertCreatedSnackBar(BuildContext context, T alertDetails) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Alert created successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}*/

class TemperatureScreen extends StatefulWidget {
  @override
  _TemperatureScreenState createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen>
    with AlertCreationMixin {
  final TextEditingController _cityController = TextEditingController();
  double _temperature = 25.0;
  String _comparison = "<";
  bool _isNextEnabled = false;

  @override
  void initState() {
    super.initState();
    _cityController.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      _isNextEnabled = _cityController.text.isNotEmpty;
    });
  }

  void _handleNext() {
    if (_isNextEnabled) {
      final temperatureAlert = {
        'city': _cityController.text,
        'temperature': _temperature,
        'comparisonOperator': _comparison,
      };

      showAlertCreatedSnackBar(context, temperatureAlert);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Temperature Alert")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select City", style: TextStyle(fontSize: 18)),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter city name",
              ),
            ),
            SizedBox(height: 20),
            Text("Comparison Operator", style: TextStyle(fontSize: 18)),
            ToggleButtons(
              isSelected: [
                _comparison == "<",
                _comparison == "=",
                _comparison == ">",
              ],
              onPressed: (int index) {
                setState(() {
                  _comparison = ["<", "=", ">"][index];
                });
              },
              children: [
                Padding(padding: EdgeInsets.all(8.0), child: Text("<")),
                Padding(padding: EdgeInsets.all(8.0), child: Text("=")),
                Padding(padding: EdgeInsets.all(8.0), child: Text(">")),
              ],
            ),
            SizedBox(height: 20),
            Text("Temperature: ${_temperature.toStringAsFixed(1)}°C",
                style: TextStyle(fontSize: 18)),
            Slider(
              min: -50,
              max: 50,
              divisions: 100,
              value: _temperature,
              label: _temperature.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _temperature = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isNextEnabled ? _handleNext : null,
              child: Text("Create Temperature Alert"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }
}

// Main Weather Change Screen (Updated)
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
              // Navigate to specific screens based on the selected option
              switch (weatherOptions[index]) {
                case "Temperature":
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TemperatureScreen(), // Ensure this matches the class name exactly
                    ),
                  );
                  break;
                case "Humidity":
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HumidityScreen(),
                    ),
                  );
                  break;
                case "Weather":
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeatherConditionScreen(),
                    ),
                  );
                  break;
                case "Sunset/Sunrise":
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SunriseSunsetScreen(),
                    ),
                  );
                  break;
                case "Wind Speed":
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WindSpeedScreen(),
                    ),
                  );
                  break;
              }
            },
          );
        },
      ),
    );
  }
}
