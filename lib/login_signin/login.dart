import 'package:flutter/material.dart';
import './first_page.dart'; // Import your frontpage.dart file

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? selectedCountry;
  bool isChecked = false;

  List<String> countryNames = [
    "India",
    "United States",
    "United Kingdom",
    "Canada",
    "Australia",
    "Germany",
    "France",
    "Japan",
    "South Korea",
    "Brazil",
    "Russia",
    "Mexico",
    "China",
    "Italy",
    "Spain",
    "Netherlands",
    "Sweden",
    "Switzerland",
    "South Africa",
    "Argentina",
    "New Zealand",
    "Saudi Arabia",
    "Turkey",
    "Belgium",
    "Norway",
    "Poland",
  ];

  @override
  void initState() {
    super.initState();
    // Set India as the default country if available
    selectedCountry = countryNames.contains("India")
        ? "India"
        : (countryNames.isNotEmpty ? countryNames[0] : null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 30.0, vertical: 40.0), // Updated padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, size: 28),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FirstPage()), // Navigate to FrontPage
                );
              },
            ),
            SizedBox(height: 10),
            Text(
              "Log In",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            /// Country Dropdown
            countryNames.isNotEmpty
                ? DropdownButtonFormField<String>(
                    value: selectedCountry,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    items: countryNames.map((String countryName) {
                      return DropdownMenuItem<String>(
                        value: countryName,
                        child: Text(countryName), // Display the country name
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCountry = newValue;
                      });
                    },
                  )
                : Center(
                    child:
                        CircularProgressIndicator()), // Show loading indicator while fetching countries
            SizedBox(height: 15),

            /// Email Input
            TextField(
              decoration: InputDecoration(
                hintText: "Please enter your account",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 15),

            /// Password Input
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 15),

            /// Checkbox & Links
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "I agree to the ",
                      style: TextStyle(fontSize: 14),
                      children: [
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextSpan(text: " User Agreement and "),
                        TextSpan(
                          text: "Children's Privacy Statement",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),

            /// Log In Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: isChecked ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Log In"),
              ),
            ),
            SizedBox(height: 15),

            /// Forgot Password
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            Spacer(), // This will push the content upwards

            /// Google Sign-in (Aligned to the bottom)
            Center(
              child: IconButton(
                icon: Image.asset(
                  "assets/images/google_logo.webp",
                  width: 30,
                  height: 30,
                ), // Use your own image
                iconSize: 40,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
