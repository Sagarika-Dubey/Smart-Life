import 'package:flutter/material.dart';
import 'package:smartlife/login_signin/verification_page.dart';
import 'package:smartlife/screens/terms_and_conditions/childrens_ps.dart';
import 'package:smartlife/screens/terms_and_conditions/privacy_policy.dart';
import 'package:smartlife/screens/terms_and_conditions/user_agreement.dart';
import './first_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String? selectedCountry;
  bool isChecked = false;

  final List<String> countryNames = [
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
    selectedCountry = "India"; // Ensuring a valid default value
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
              MaterialPageRoute(builder: (context) => const FirstPage()),
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

              /// Checkbox & Links (Preventing overflow)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                        children: [
                          _buildLink("Privacy Policy", () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PrivacyPolicy()),
                            );
                          }),
                          const TextSpan(text: " , "),
                          _buildLink("User Agreement", () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserAgreement()),
                            );
                          }),
                          const TextSpan(text: " and "),
                          _buildLink("Children's Privacy Statement", () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Childrensps()),
                            );
                          }),
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerificationPage()),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isChecked ? Colors.blue : Colors.grey[300],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Get Verification Code"),
                ),
              ),
              const SizedBox(height: 15),

              /// Google Sign-in Button
              Center(
                child: IconButton(
                  icon: Image.asset(
                    "assets/images/google_logo.webp",
                    width: 30,
                    height: 30,
                  ),
                  iconSize: 40,
                  onPressed: () {
                    // Implement Google Sign-in functionality here
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper function to create links
  WidgetSpan _buildLink(String text, VoidCallback onTap) {
    return WidgetSpan(
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
