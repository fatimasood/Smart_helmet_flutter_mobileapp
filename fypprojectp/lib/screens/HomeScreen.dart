import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> openBluetoothSettings() async {
    const String iosBluetoothSettings = "App-Prefs:Bluetooth";

    try {
      if (await canLaunch(iosBluetoothSettings)) {
        await launch(iosBluetoothSettings);
      } else {
        // If iOS deep link is not available, try using Android Intent
        AndroidIntent intent = AndroidIntent(
          action: 'android.settings.BLUETOOTH_SETTINGS',
        );
        await intent.launch();
      }
    } catch (e) {
      print('Error opening Bluetooth settings: $e');
    }
  }

  void onTap() {
    Future.delayed(Duration(milliseconds: 100), () {
      openBluetoothSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, left: 25.0, right: 25.0, bottom: 10.8),
              child: Text(
                "Please switch on your Bluetooth for tracking your ride ",
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff9d6bff),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 180,
              height: 180,
              child: Center(
                child: Image.asset(
                  "lib/assets/blueooth.png",
                  height: 165,
                  width: 165,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
