import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fypprojectp/screens/bluetooth_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  final BluetoothController bluetoothController = BluetoothController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<BluetoothController>(
        init: bluetoothController,
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
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
                  onTap: () {
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
                              child: StreamBuilder<List<ScanResult>>(
                                stream: controller.scanResults,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        final data = snapshot.data![index];
                                        return Card(
                                          elevation: 2,
                                          child: ListTile(
                                            title: Text(
                                                data.device.name ?? 'Unknown'),
                                            subtitle: Text(data.device.id.id),
                                            trailing:
                                                Text(data.rssi.toString()),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return const Center(
                                      child: Text('No device found'),
                                    );
                                  }
                                },
                              ),
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
          );
        },
      ),
    );
  }
}
