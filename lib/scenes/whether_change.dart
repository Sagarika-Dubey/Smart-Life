import 'package:flutter/material.dart';
import 'dart:math';

// Shared Alert Creation Mixin with improved feedback
mixin AlertCreationMixin<T> {
  void showAlertCreatedSnackBar(BuildContext context, T alertDetails) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text('Alert created successfully!'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 209, 245, 211),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

// Shared UI Components
class AppConstants {
  static const EdgeInsets contentPadding = EdgeInsets.all(20.0);
  static const double verticalSpacing = 24.0;
  static const double cardRadius = 12.0;

  static const TextStyle headerStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  static InputDecoration inputDecoration(String hint, IconData? icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: icon != null ? Icon(icon) : null,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
            color: const Color.fromARGB(255, 255, 255, 255), width: 2.0),
      ),
    );
  }

  static ButtonStyle primaryButtonStyle() {
    return ElevatedButton.styleFrom(
      minimumSize: Size(double.infinity, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2,
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
      appBar: AppBar(
        title: Text("Humidity Alert"),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color.fromARGB(255, 255, 255, 255), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: AppConstants.contentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("City", style: AppConstants.headerStyle),
                      SizedBox(height: 8),
                      TextField(
                        controller: _cityController,
                        decoration: AppConstants.inputDecoration(
                          "Enter city name",
                          Icons.location_city,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppConstants.verticalSpacing),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Alert Condition", style: AppConstants.headerStyle),
                      SizedBox(height: 16),
                      Text("Alert me when humidity is:"),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: SegmentedButton<String>(
                                segments: [
                                  ButtonSegment(
                                      value: "<", label: Text("Below")),
                                  ButtonSegment(
                                      value: "=", label: Text("Equal")),
                                  ButtonSegment(
                                      value: ">", label: Text("Above")),
                                ],
                                selected: {_comparison},
                                onSelectionChanged: (Set<String> newSelection) {
                                  setState(() {
                                    _comparison = newSelection.first;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Text("Humidity: ${_humidity.toStringAsFixed(1)}%",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          Icon(Icons.water_drop, color: Colors.blue),
                          Expanded(
                            child: Slider(
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppConstants.verticalSpacing),
              ElevatedButton.icon(
                onPressed: _isNextEnabled ? _handleNext : null,
                icon: Icon(Icons.notifications_active),
                label: Text("CREATE HUMIDITY ALERT"),
                style: AppConstants.primaryButtonStyle(),
              ),
            ],
          ),
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

  final Map<String, IconData> _conditionIcons = {
    'Sunny': Icons.wb_sunny,
    'Cloudy': Icons.cloud,
    'Rainy': Icons.water_drop,
    'Snowy': Icons.ac_unit,
    'Stormy': Icons.thunderstorm,
    'Windy': Icons.air,
    'Foggy': Icons.cloud_queue,
    'Clear': Icons.nightlight_round,
    'Partly Cloudy': Icons.wb_cloudy
  };

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
      appBar: AppBar(
        title: Text("Weather Condition Alert"),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color.fromARGB(255, 253, 253, 253), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: AppConstants.contentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("City", style: AppConstants.headerStyle),
                      SizedBox(height: 8),
                      TextField(
                        controller: _cityController,
                        decoration: AppConstants.inputDecoration(
                          "Enter city name",
                          Icons.location_city,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppConstants.verticalSpacing),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Weather Condition",
                          style: AppConstants.headerStyle),
                      SizedBox(height: 16),
                      Text("Alert me when weather condition is:"),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(4),
                        child: DropdownButtonFormField<String>(
                          value: _selectedCondition,
                          hint: Text("Choose a condition"),
                          items: _weatherConditions.map((condition) {
                            return DropdownMenuItem(
                              value: condition,
                              child: Row(
                                children: [
                                  Icon(_conditionIcons[condition]),
                                  SizedBox(width: 10),
                                  Text(condition),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCondition = value;
                              _validateInputs();
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          icon: Icon(Icons.arrow_drop_down_circle),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppConstants.verticalSpacing),
              ElevatedButton.icon(
                onPressed: _isNextEnabled ? _handleNext : null,
                icon: Icon(Icons.notifications_active),
                label: Text("CREATE WEATHER CONDITION ALERT"),
                style: AppConstants.primaryButtonStyle(),
              ),
            ],
          ),
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
      appBar: AppBar(
        title: Text("Sunrise/Sunset Alert"),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange[50]!, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: AppConstants.contentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("City", style: AppConstants.headerStyle),
                      SizedBox(height: 8),
                      TextField(
                        controller: _cityController,
                        decoration: AppConstants.inputDecoration(
                          "Enter city name",
                          Icons.location_city,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppConstants.verticalSpacing),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sun Event", style: AppConstants.headerStyle),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _sunEvent = 'Sunrise';
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _sunEvent == 'Sunrise'
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Icon(Icons.wb_sunny,
                                        color: _sunEvent == 'Sunrise'
                                            ? Colors.white
                                            : Colors.grey[700],
                                        size: 32),
                                    SizedBox(height: 8),
                                    Text('Sunrise',
                                        style: TextStyle(
                                          color: _sunEvent == 'Sunrise'
                                              ? Colors.white
                                              : Colors.grey[700],
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _sunEvent = 'Sunset';
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _sunEvent == 'Sunset'
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Icon(Icons.nightlight_round,
                                        color: _sunEvent == 'Sunset'
                                            ? Colors.white
                                            : Colors.grey[700],
                                        size: 32),
                                    SizedBox(height: 8),
                                    Text('Sunset',
                                        style: TextStyle(
                                          color: _sunEvent == 'Sunset'
                                              ? Colors.white
                                              : Colors.grey[700],
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text("Time",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      SizedBox(height: 8),
                      InkWell(
                        onTap: () => _selectTime(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.access_time, color: Colors.blue[700]),
                              SizedBox(width: 10),
                              Text(_selectedTime.format(context),
                                  style: TextStyle(fontSize: 16)),
                              Spacer(),
                              Icon(Icons.arrow_drop_down, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppConstants.verticalSpacing),
              ElevatedButton.icon(
                onPressed: _isNextEnabled ? _handleNext : null,
                icon: Icon(Icons.notifications_active),
                label: Text("CREATE SUN EVENT ALERT"),
                style: AppConstants.primaryButtonStyle(),
              ),
            ],
          ),
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
      appBar: AppBar(
        title: Text("Wind Speed Alert"),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color.fromARGB(255, 255, 255, 255), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: AppConstants.contentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("City", style: AppConstants.headerStyle),
                      SizedBox(height: 8),
                      TextField(
                        controller: _cityController,
                        decoration: AppConstants.inputDecoration(
                          "Enter city name",
                          Icons.location_city,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppConstants.verticalSpacing),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Wind Conditions", style: AppConstants.headerStyle),
                      SizedBox(height: 16),
                      Text("Alert me when wind speed is:"),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: SegmentedButton<String>(
                                segments: [
                                  ButtonSegment(
                                      value: "<", label: Text("Below")),
                                  ButtonSegment(
                                      value: "=", label: Text("Equal")),
                                  ButtonSegment(
                                      value: ">", label: Text("Above")),
                                ],
                                selected: {_comparison},
                                onSelectionChanged: (Set<String> newSelection) {
                                  setState(() {
                                    _comparison = newSelection.first;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Wind Speed:",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.blue[700],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              "${_windSpeed.toStringAsFixed(1)} km/h",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.air, color: Colors.blue),
                          Expanded(
                            child: Slider(
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
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text("Wind Direction (Optional):",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      SizedBox(height: 12),
                      Container(
                        height: 100,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: GridView.count(
                          crossAxisCount: 4,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.5,
                          physics: NeverScrollableScrollPhysics(),
                          children: _windDirections.map((direction) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedDirection =
                                      _selectedDirection == direction
                                          ? null
                                          : direction;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _selectedDirection == direction
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  direction,
                                  style: TextStyle(
                                    color: _selectedDirection == direction
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppConstants.verticalSpacing),
              ElevatedButton.icon(
                onPressed: _isNextEnabled ? _handleNext : null,
                icon: Icon(Icons.notifications_active),
                label: Text("CREATE WIND SPEED ALERT"),
                style: AppConstants.primaryButtonStyle(),
              ),
            ],
          ),
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
      appBar: AppBar(
        title: Text("Temperature Alert"),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader("Select City"),
              SizedBox(height: 8),
              _buildCityInput(),
              SizedBox(height: 24),
              _buildSectionHeader("Comparison Operator"),
              SizedBox(height: 8),
              _buildComparisonToggle(),
              SizedBox(height: 24),
              _buildTemperatureSection(),
              SizedBox(height: 32),
              _buildCreateButton(),
              SizedBox(height: 16),
              _buildAlertPreview(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildCityInput() {
    return TextField(
      controller: _cityController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        hintText: "Enter city name",
        prefixIcon: Icon(Icons.location_city),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  Widget _buildComparisonToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: EdgeInsets.all(8),
      child: ToggleButtons(
        borderRadius: BorderRadius.circular(8),
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        selectedBorderColor: Theme.of(context).colorScheme.primary,
        selectedColor: Theme.of(context).colorScheme.primary,
        constraints: BoxConstraints(minWidth: 80, minHeight: 45),
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
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Less than",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Equal to",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Greater than",
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildTemperatureSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Temperature",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "${_temperature.toStringAsFixed(1)}°C",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.ac_unit, color: Colors.blue),
              Expanded(
                child: Slider(
                  min: -50,
                  max: 50,
                  divisions: 100,
                  value: _temperature,
                  label: _temperature.toStringAsFixed(1),
                  activeColor: Theme.of(context).colorScheme.primary,
                  inactiveColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  onChanged: (value) {
                    setState(() {
                      _temperature = value;
                    });
                  },
                ),
              ),
              Icon(Icons.whatshot, color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreateButton() {
    return ElevatedButton(
      onPressed: _isNextEnabled ? _handleNext : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_active),
          SizedBox(width: 8),
          Text(
            "Create Temperature Alert",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
    );
  }

  Widget _buildAlertPreview() {
    if (!_isNextEnabled) return SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Alert Preview",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Notify me when temperature in ${_cityController.text} is ${_getComparisonText()} ${_temperature.toStringAsFixed(1)}°C",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  String _getComparisonText() {
    switch (_comparison) {
      case "<":
        return "less than";
      case "=":
        return "equal to";
      case ">":
        return "greater than";
      default:
        return "";
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }
}

// Main Weather Change Screen (Updated)
class WeatherChangeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> weatherOptions = [
    {
      "title": "Temperature",
      "icon": Icons.thermostat,
      "color": Colors.orange,
      "description": "Set alerts based on temperature changes"
    },
    {
      "title": "Humidity",
      "icon": Icons.water_drop,
      "color": Colors.blue,
      "description": "Get notified when humidity levels change"
    },
    {
      "title": "Weather Condition",
      "icon": Icons.cloud,
      "color": Colors.grey,
      "description": "Create alerts for specific weather conditions"
    },
    {
      "title": "Sunset/Sunrise",
      "icon": Icons.wb_sunny,
      "color": Colors.amber,
      "description": "Set alerts for sunrise and sunset times"
    },
    {
      "title": "Wind Speed",
      "icon": Icons.air,
      "color": Colors.teal,
      "description": "Monitor changes in wind speed"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather Alerts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Show help dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Weather Alerts Help"),
                  content: Text(
                      "Select a weather condition to create custom alerts based on your preferences."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("GOT IT"),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: weatherOptions.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              margin: EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  // Navigate to specific screens based on the selected option
                  switch (weatherOptions[index]["title"]) {
                    case "Temperature":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TemperatureScreen(),
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
                    case "Weather Condition":
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              weatherOptions[index]["color"].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          weatherOptions[index]["icon"],
                          color: weatherOptions[index]["color"],
                          size: 28,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              weatherOptions[index]["title"],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              weatherOptions[index]["description"],
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
