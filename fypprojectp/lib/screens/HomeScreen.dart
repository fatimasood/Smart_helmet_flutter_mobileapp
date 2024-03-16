import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fypprojectp/screens/UserAccountDetail/EditInformation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  final List<BluetoothDevice> _devices = [];
  BluetoothConnection? _connection;

  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    checkEmail();
    _initializeBluetooth();
  }

  Future<void> checkEmail() async {
    prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    print('emai: $email');
    if (email == null) {
      // Show dialog with the message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Welcome Back",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff6617ff),
                  fontWeight: FontWeight.w800,
                  fontSize: 18),
            ),
            content: const Text(
              "Updation Required!",
              style: TextStyle(
                  color: Color(0xff6617ff),
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditInformation(),
                    ),
                  );
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _initializeBluetooth() async {
    // Ensure Bluetooth is enabled
    bool? isEnabled = await _bluetooth.isEnabled;
    if (isEnabled != null && !isEnabled) {
      await _bluetooth.requestEnable();
    }
    _startDiscovery();
  }

  void _startDiscovery() async {
    try {
      print("Starting discovery...");
      _bluetooth
          .startDiscovery()
          .listen((BluetoothDiscoveryResult result) async {
        print(
            'Discovered ${result.device.address}: ${result.device.name ?? 'Unknown Device'}');
        print('Bonded: ${result.device.isBonded}');

        if (!result.device.isBonded) {
          await _bondDevice(result.device);
        }

        setState(() {
          _devices.add(result.device);
        });
      });
    } catch (error) {
      print('Error during discovery: $error');
    }
  }

  Future<void> _bondDevice(BluetoothDevice device) async {
    try {
      print(
          'Bonding with ${device.name ?? 'Unknown Device'} at ${device.address}...');

      final List<BluetoothDevice> bondedDevices =
          await FlutterBluetoothSerial.instance.getBondedDevices();

      if (!bondedDevices.contains(device)) {
        await FlutterBluetoothSerial.instance
            .bondDeviceAtAddress(device.address);
      }

      print('Bonded successfully with ${device.name ?? 'Unknown Device'}');
    } catch (error) {
      print('Error bonding with ${device.name ?? 'Unknown Device'}: $error');
      // Handle the error, possibly display a user-friendly message.
    }
  }

  void _connectToDevice(BluetoothDevice device) async {
    try {
      print(
          'Connecting to ${device.name ?? 'Unknown Device'} at ${device.address}...');
      _connection = await BluetoothConnection.toAddress(device.address);

      _connection?.input?.listen((Uint8List? data) {
        if (data != null) {
          print('Data received: $data');
          // Handle received data from your ESP32 device
        }
      }, onDone: () {
        print('Connection to ${device.name ?? 'Unknown Device'} closed.');
      });

      print('Connected to ${device.name ?? 'Unknown Device'}');
    } catch (error) {
      print('Error connecting to ${device.name ?? 'Unknown Device'}: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, left: 20, right: 20, bottom: 0.0),
              child: Text(
                "Kindly switch on your Bluetooth for tracking your ride ",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff9d6bff),
                  ),
                ),
              ),
            ),
            /* GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SignUp()), // Navigate to Home screen
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 0.0,
                  left: 20,
                  right: 20,
                  bottom: 0.0,
                ),
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff9d6bff),
                    ),
                  ),
                ),
              ),
            ),*/
            SizedBox(height: 15.0),
            GestureDetector(
              onTap: () {
                print("Button pressed. Initiating device scan...");
                _startDiscovery();

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Available Bluetooth Devices",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff6617ff),
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      content: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
                          itemCount: _devices.length,
                          itemBuilder: (context, index) {
                            BluetoothDevice device = _devices[index];
                            return ListTile(
                              title: Text(device.name ?? 'Unknown Device'),
                              subtitle: Text(device.address),
                              onTap: () {
                                print(
                                    'Device selected: ${device.name ?? 'Unknown Device'}');
                                _connectToDevice(device);
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
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
      ),
    );
  }

  void _sendMessageToDevice(String message) {
    if (_connection != null && _connection!.isConnected) {
      _connection!.output.add(Uint8List.fromList(utf8.encode('$message\n')));
      _connection!.output.allSent.then((_) {
        print('Message sent: $message');
      });
    } else {
      print('Not connected to any device.');
    }
  }

  @override
  void dispose() {
    print('Disposing resources...');
    _bluetooth.cancelDiscovery();
    _connection?.close();
    super.dispose();
  }
}
