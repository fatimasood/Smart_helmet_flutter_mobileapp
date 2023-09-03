import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var actions;

  //function to open blutooth settings

  Future<void> openBluetoothSettings() async {
    await SystemChannels.platform.invokeListMethod('Bluetooth.openSettings');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, left: 25.0, right: 25.0, bottom: 10.8),
              child: Text(
                "Please switch on your bluetooth for tracking your ride ",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff9d6bff),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: InkWell(
              onTap: openBluetoothSettings,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'lib/assets/bluetooth.png', // Replace with the actual path to your Bluetooth image
                  width: 24, // Adjust the size as needed
                  height: 24,
                  color: Colors.white, // Optional: Apply a color to the image
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
