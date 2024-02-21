import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  // Bluetooth instance
  FlutterBlue flutterBlue = FlutterBlue.instance;

  Future<void> initializeBluetooth() async {
    try {
      // Wait until Bluetooth is turned on
      await flutterBlue.state.firstWhere((state) => state == BluetoothState.on);

      print('Bluetooth is on and initialized!');
    } catch (e) {
      print('Error initializing Bluetooth: $e');
    }
  }

  // Scan devices
  Future<void> scanDevices() async {
    try {
      // Initialize Bluetooth first
      await initializeBluetooth();

      // Start scanning
      await flutterBlue.startScan(timeout: const Duration(seconds: 5));

      // Allow some time for scanning (you can adjust this duration)
      await Future.delayed(const Duration(seconds: 3));

      // Stop scanning
      flutterBlue.stopScan();
    } catch (e) {
      print('Error during scanning: $e');
    }
  }

  // Show all available devices
  Stream<List<ScanResult>> get scanResults => flutterBlue.scanResults;
}
