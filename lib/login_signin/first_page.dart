import 'package:flutter/material.dart';
import './login.dart';
import './sigin.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 247, 223, 223),
              Color.fromARGB(255, 250, 243, 243),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 250,
                    height: 250,
                  ),
                ),
                Text("Make Life Simple")
              ],
            ),
            SizedBox(
              height: 140,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 122, 40, 40),
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Log In',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side:
                    const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 114, 12, 12)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                // Add functionality for "Try as Guest" if needed.
              },
              child: const Text(
                'Try as Guest',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}
