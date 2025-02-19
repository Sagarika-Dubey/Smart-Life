import 'package:flutter/material.dart';
import 'package:smartlife/login_signin/verification_page.dart';
import 'package:smartlife/screens/terms_and_conditions/childrens_ps.dart';
import 'package:smartlife/screens/terms_and_conditions/privacy_policy.dart';
import 'package:smartlife/screens/terms_and_conditions/user_agreement.dart';
import './first_page.dart'; // Import your frontpage.dart file

class Sigin extends StatefulWidget {
  const Sigin({super.key});

  @override
  State<Sigin> createState() => _LoginState();
}

class _LoginState extends State<Sigin> {
  String? selectedCountry;
  bool isChecked = false;

  // Hardcoded list of country names
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
    selectedCountry =
        countryNames.contains("India") ? "India" : countryNames[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FirstPage()),
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            const Text(
              "Register",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            /// Country Dropdown
            DropdownButtonFormField<String>(
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
                  child: Text(countryName),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCountry = newValue;
                });
              },
            ),
            const SizedBox(height: 15),

            /// Email Input
            TextField(
              decoration: InputDecoration(
                hintText: "Email Address",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),

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
                  child: RichText(
                    text: TextSpan(
                      text: "I agree to the ",
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PrivacyPolicy()),
                              );
                            },
                            child: const Text(
                              "Privacy Policy",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        const TextSpan(text: " , "),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UserAgreement()),
                              );
                            },
                            child: const Text(
                              "User Agreement",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        const TextSpan(text: " and "),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Childrensps()),
                              );
                            },
                            child: const Text(
                              "Children's Privacy Statement",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        const TextSpan(text: "."),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),

            /// Get Verification Code Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: isChecked
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerificationPage()),
                        );
                      }
                    : null, // Disables button if isChecked is false
                style: ElevatedButton.styleFrom(
                  backgroundColor: isChecked
                      ? Colors.blue
                      : Colors.grey[300], // Change color when disabled
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Get Verification Code"),
              ),
            ),
            const SizedBox(height: 15),

            const Spacer(), // Pushes the Google button to the bottom

            /// Google Sign-in (Aligned to the bottom)
            Center(
              child: IconButton(
                icon: Image.asset(
                  "assets/images/google_logo.webp",
                  width: 30,
                  height: 30,
                ),
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
