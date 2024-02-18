import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  void onTap() async {
    // Check if Bluetooth is available on the device
    if (await flutterBlue.isAvailable) {
      // Request location permission
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();

      if (statuses[Permission.location] == PermissionStatus.granted) {
        List<BluetoothDevice> devices = await _scanForDevices();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Available Bluetooth Devices",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff6617ff),
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              content: Container(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (devices.isEmpty)
                        Center(
                          child: Text(
                            "No devices available at this moment.",
                            style: TextStyle(
                              color: Color(0xff6617ff),
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                          ),
                        )
                      else
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: ListView.builder(
                            itemCount: devices.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(devices[index].name),
                                onTap: () {
                                  Navigator.pop(context); // Close the dialog
                                  _connectToDevice(devices[index]);
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      } else {
        // Location permission not granted
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Location Permission Required",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff6617ff),
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              content: const Text(
                "Location permission is required to discover Bluetooth devices.",
                textAlign: TextAlign.center,
              ),
            );
          },
        );
      }
    } else {
      // Bluetooth is not available on the device
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Bluetooth Not Available",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff6617ff),
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            content: const Text(
              "Bluetooth is not available on this device.",
              textAlign: TextAlign.center,
            ),
          );
        },
      );
    }
  }

  Future<List<BluetoothDevice>> _scanForDevices() async {
    List<BluetoothDevice> devices = [];

    try {
      await flutterBlue.startScan(timeout: Duration(seconds: 10));
      flutterBlue.scanResults.listen((List<ScanResult> results) {
        for (ScanResult result in results) {
          devices.add(result.device);
        }
      });
    } catch (e) {
      print('Error scanning for devices: $e');
    }

    return devices;
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      print('Connected to ${device.name}');
      // Implement your logic for handling the connected device here
    } catch (e) {
      print('Error connecting to device: $e');
    }
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
                top: 15.0,
                left: 25.0,
                right: 25.0,
                bottom: 10.8,
              ),
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
