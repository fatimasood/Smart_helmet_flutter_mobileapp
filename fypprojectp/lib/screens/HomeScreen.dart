import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fypprojectp/constants.dart';
import 'package:fypprojectp/main.dart';
import 'package:fypprojectp/screens/TimerWidget.dart';
import 'package:fypprojectp/screens/UserAccountDetail/EditInformation.dart';
import 'package:fypprojectp/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

String receivedData = '';
bool bluetoothconnected = false;
bool _isConnected = false;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //location

  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  static const LatLng _pApplePark = LatLng(37.3346, -122.0890);

  LatLng? _currentP = null;

  Map<PolylineId, Polyline> polylines = {};
  //bluetooth
  final FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  final List<BluetoothDevice> _devices = [];
  BluetoothConnection? _connection;
  final bool _isBluetoothConnected =
      false; // check either bluetooth is connected or not

  late SharedPreferences prefs;
  bool isUpdateDialogShown = false;

  @override
  void initState() {
    super.initState();
    checkEmail();
    _initializeBluetooth();
    // bluetoothconnected = false;

    getLocationUpdates().then(
      (_) => {
        getPolylinePoints().then((coordinates) => {
              generatePolyLineFromPoints(coordinates),
            }),
      },
    );
    _connection?.input?.listen((Uint8List? data) {
      if (data != null) {
        print('Data save for accident: $data');
        setState(() {
          receivedData = utf8.decode(data); // Store received data
        });
        _saveDataInSharedPreferences(receivedData);
        print('receivedData $receivedData ');

        checkAccidentOccur(); // Check for accident detection
      }
    }, onDone: () {
      print('Test Done ');
    });
  }

  Future<void> checkEmail() async {
    prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString('email');

    print('emai: $email');
    if (email == null && isUpdateDialogShown == false) {
      // Show dialog with the message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          isUpdateDialogShown = true;
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
                      builder: (context) => const EditInformation(),
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
          setState(() {
            receivedData = utf8.decode(data); // Store received data
          });
          _saveDataInSharedPreferences(receivedData);
          checkAccidentOccur(); // Check for accident detection
        }
      }, onDone: () {
        print('Connection to ${device.name ?? 'Unknown Device'} closed.');
      });

      print('Connected to ${device.name ?? 'Unknown Device'}');
      setState(() {
        bluetoothconnected = true;
        Navigator.pop(context);
      });

      Utils().toastMessage("Bluetooth Connected...!!");

      // ignore: use_build_context_synchronously
      /* Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BluetoothConnectedScreen(data: receivedData),
        ),
      );*/
    } catch (error) {
      print('Error connecting to ${device.name ?? 'Unknown Device'}: $error');
    }
  }

  Future<void> _saveDataInSharedPreferences(String data) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('Bluetooth_data', data);
    print('Data saved in SharedPreferences: $data');
    dataSaved = data;
  }

//accident detection
  Future<void> _accidentDetection() async {
    // Ensure Bluetooth is enabled
    bool? isEnabled = await _bluetooth.isEnabled;
    if (isEnabled != null && !isEnabled) {
      await _bluetooth.requestEnable();
    }
    _startDiscovery();
  }

  Future<void> checkAccidentOccur() async {
    // prefs = await SharedPreferences.getInstance();

    //  String? accidentData = prefs.getString('Bluetooth_data');

    print('Accident Data: $dataSaved');

    if (dataSaved.contains('Accident Detected')) {
      print('Accident Detected!');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Padding(
              padding:
                  const EdgeInsets.only(top: 20, bottom: 20, left: 0, right: 0),
              child: Text(
                "Emergency SOS",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff6617ff),
                  ),
                ),
              ),
            ),
            content: TimerWidget(
              fullName: 'fullName',
              cnic: 'cnic',
              bloodGroup: 'bloodGroup',
              address: 'address',
              emerContact: 'emerContact',
              emerContact1: 'emerContact1',
              emerContact2: 'emerContact2',
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 40,
                  width: 140,
                  child: InkWell(
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade200),
                        child: Text(
                          "Close",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff6617ff),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      print('No accident detected.');
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
            if (!bluetoothconnected)
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
            if (bluetoothconnected)
              Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, left: 20, right: 20, bottom: 0.0),
                child: Text(
                  "Let's kick off this ride with excitement and safety!   ",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff9d6bff),
                    ),
                  ),
                ),
              ),

            SizedBox(height: 15.0),
            if (!bluetoothconnected)
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
                                  if (_isBluetoothConnected) {
                                    Navigator.pop(context);
                                  }
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
            //  SizedBox(height: 200,),
            if (bluetoothconnected)
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 20, right: 20, bottom: 20),
                child: Container(
                  height: 200,
                  child: _currentP == null
                      ? const Center(
                          child: Text(
                            "Loading...",
                            style: TextStyle(color: Color(0xff6617ff)),
                          ),
                        )
                      : GoogleMap(
                          onMapCreated: ((GoogleMapController controller) =>
                              _mapController.complete(controller)),
                          initialCameraPosition: CameraPosition(
                            target: _pGooglePlex,
                            zoom: 13,
                          ),
                          markers: {
                            Marker(
                              markerId: MarkerId("_currentLocation"),
                              icon: BitmapDescriptor.defaultMarker,
                              position: _currentP!,
                            ),
                            Marker(
                                markerId: MarkerId("_sourceLocation"),
                                icon: BitmapDescriptor.defaultMarker,
                                position: _pGooglePlex),
                            Marker(
                                markerId: MarkerId("_destionationLocation"),
                                icon: BitmapDescriptor.defaultMarker,
                                position: _pApplePark)
                          },
                          polylines: Set<Polyline>.of(polylines.values),
                        ),
                ),
              ),
            // SizedBox(height: 100,),
            if (bluetoothconnected)
              // Display received data
              Padding(
                padding: const EdgeInsets.only(
                    top: 2, left: 20, right: 20, bottom: 20),
                child: Container(
                  height: 100,
                  width: 310,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Color(0xff6617ff),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Received Data: $dataSaved',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff9d6bff),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            /* GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 0.0,
                  left: 20,
                  right: 20,
                  bottom: 0.0,
                ),
                child: Text(
                  "Msg Check",
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('Disposing resources...');
    _bluetooth.cancelDiscovery();
    _connection?.close();
    super.dispose();
  }

  //for location
  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
      PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }
}
