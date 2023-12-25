import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  //function to open blutooth settings
  Future<void> openBluetoothSettings() async {
    // The Bluetooth settings deep link for Android
    const String androidBluetoothSettings =
        "package:com.android.settings/com.android.settings.bluetooth.BluetoothSettings";

    // The Bluetooth settings deep link for iOS
    const String iosBluetoothSettings = "App-Prefs:Bluetooth";

    try {
      if (await canLaunch(androidBluetoothSettings)) {
        // For Android, open the Bluetooth settings page
        await launch(androidBluetoothSettings);
      } else if (await canLaunch(iosBluetoothSettings)) {
        // For iOS, open the Bluetooth settings page
        await launch(iosBluetoothSettings);
      } else {
        // If the deep link is not available on the device, show an error message
        throw 'Could not open Bluetooth settings.';
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
                "Please switch on your bluetooth for tracking your ride ",
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
