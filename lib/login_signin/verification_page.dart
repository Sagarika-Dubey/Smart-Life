import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:smartlife/login_signin/set_password.dart';
import 'package:smartlife/login_signin/sigin.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage({super.key});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController pinController = TextEditingController();
  final FocusNode pinFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Automatically focus the input field when the page loads
    Future.delayed(Duration(milliseconds: 500), () {
      FocusScope.of(context).requestFocus(pinFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Better navigation handling
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Enter Verification Code",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Pinput(
                controller: pinController,
                focusNode: pinFocusNode,
                length: 6,
                autofocus: true,
                keyboardType: TextInputType.number,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                ),
                onCompleted: (pin) {
                  // Handle pin verification
                  print("Entered PIN: $pin");
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "A verification code has been sent to your email.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Handle resend logic
                  print("Resend Code");
                },
                child: const Text(
                  "Didn't get a code?",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SetPasswordPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 103, 104, 105), // Change color when disabled
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
