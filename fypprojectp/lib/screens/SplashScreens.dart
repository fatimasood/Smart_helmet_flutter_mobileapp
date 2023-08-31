import 'package:flutter/material.dart';

import 'firstScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required String title});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay for demonstration purpose
    Future.delayed(const Duration(seconds: 5), () {
      // After the delay, navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => firstScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding:
            const EdgeInsets.fromLTRB(74 * 1.0, 264 * 1.0, 63 * 1.0, 384 * 1.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1 * 1.0),
          gradient: const LinearGradient(
              begin: Alignment(-0.951, -1),
              end: Alignment(1.508, 1.437),
              colors: <Color>[
                Color(0xff6617ff),
                Color(0xff9d6bff),
                Color(0xffffffff),
                Color(0xff8048ec)
              ],
              stops: <double>[
                0,
                0.792,
                1,
                1
              ]),
        ),
      ),
    );
  }
}
