import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  // Bluetooth instance
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  // Scan devices
  Future<void> scanDevices() async {
    try {
      // Start scanning
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

      // Allow some time for scanning (you can adjust this duration)
      await Future.delayed(const Duration(seconds: 3));

      // Stop scanning
      FlutterBluePlus.stopScan();
    } catch (e) {
      print('Error during scanning: $e');
    }
  }

  // Show all available devices
  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
}
