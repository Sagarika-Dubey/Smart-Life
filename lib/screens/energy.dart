import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lottie/lottie.dart';

class EnergySavingHome extends StatefulWidget {
  @override
  _EnergySavingHomeState createState() => _EnergySavingHomeState();
}

class _EnergySavingHomeState extends State<EnergySavingHome> {
  double currentPower = 0.0;
  bool hasPowerMeter = false;
  double todayUsage = 0.0;
  double dailyCost = 0.0;
  int energySavingDuration = 0;

  // Energy-saving suggestions data
  final List<EnergySavingSuggestion> suggestions = [
    EnergySavingSuggestion(
      title: 'Energy-efficient lighting',
      subtitle: 'Expected Energy Savings: 10% ~ 15%',
      icon: Icons.lightbulb_outline,
      image: 'assets/images/led_bulb.png',
      isActivated: false,
    ),
    EnergySavingSuggestion(
      title: 'Automatic temperature control',
      subtitle: 'Expected Energy Savings: 20% ~ 30%',
      icon: Icons.thermostat,
      image: 'assets/images/smart_thermostat.png',
      isActivated: false,
    ),
    EnergySavingSuggestion(
      title: 'Smart power strips',
      subtitle: 'Expected Energy Savings: 5% ~ 10%',
      icon: Icons.power,
      image: 'assets/images/power_strip.png',
      isActivated: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Energy Saver',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[600],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEnergyUsageSection(),
            _buildEnergyUsageChart(),
            _buildDeviceMonitor(),
            _buildEnergySavingSuggestions(),
          ],
        ),
      ),
    );
  }

  Widget _buildEnergyUsageSection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green[600],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today\'s Energy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '${todayUsage.toStringAsFixed(2)} kWh',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${dailyCost.toStringAsFixed(2)} spent',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Image.asset(
            'assets/images/energy_wave.png',
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget _buildEnergyUsageChart() {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Energy Usage Trend',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 3),
                        FlSpot(1, 2),
                        FlSpot(2, 5),
                        FlSpot(3, 3.5),
                        FlSpot(4, 4),
                        FlSpot(5, 3),
                        FlSpot(6, 4.5),
                      ],
                      isCurved: true,
                      color: Colors.green[600],
                      barWidth: 4,
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.green.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceMonitor() {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Monitor',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current Power (W): $currentPower',
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  value: hasPowerMeter,
                  onChanged: (bool value) {
                    setState(() {
                      hasPowerMeter = value;
                      if (value) {
                        currentPower = 85.5; // Example power reading
                        todayUsage = 2.5;
                        dailyCost = 0.35;
                        energySavingDuration = 45;
                      } else {
                        currentPower = 0.0;
                        todayUsage = 0.0;
                        dailyCost = 0.0;
                        energySavingDuration = 0;
                      }
                    });
                  },
                  activeColor: Colors.green[600],
                ),
              ],
            ),
            SizedBox(height: 16),
            hasPowerMeter
                ? Text(
                    'Power metering enabled',
                    style: TextStyle(color: Colors.green),
                  )
                : Text(
                    'You do not have a device that supports power metering yet',
                    style: TextStyle(color: Colors.red),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnergySavingSuggestions() {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Energy-Saving Suggestions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ...suggestions
                .map((suggestion) => _buildSuggestionTile(suggestion))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionTile(EnergySavingSuggestion suggestion) {
    return ListTile(
      leading: Image.asset(
        suggestion.image,
        width: 50,
        height: 50,
      ),
      title: Text(suggestion.title),
      subtitle: Text(suggestion.subtitle),
      trailing: IconButton(
        icon: Icon(
          suggestion.isActivated
              ? Icons.check_circle
              : Icons.add_circle_outline,
          color: suggestion.isActivated ? Colors.green : Colors.grey,
        ),
        onPressed: () {
          setState(() {
            suggestion.isActivated = !suggestion.isActivated;
          });
        },
      ),
    );
  }
}

class EnergySavingSuggestion {
  String title;
  String subtitle;
  IconData icon;
  String image;
  bool isActivated;

  EnergySavingSuggestion({
    this.title = '',
    this.subtitle = '',
    this.icon = Icons.lightbulb_outline,
    this.image = '',
    this.isActivated = false,
  });
}
