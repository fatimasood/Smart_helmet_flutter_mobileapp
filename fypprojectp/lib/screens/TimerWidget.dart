import 'dart:async';
import 'dart:math';

import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class TimerWidget extends StatefulWidget {
  final String fullName;
  final String cnic;
  final String bloodGroup;
  final String address;
  final String emerContact;
  final String emerContact1;
  final String emerContact2;

  TimerWidget({
    Key? key,
    required this.fullName,
    required this.cnic,
    required this.bloodGroup,
    required this.address,
    required this.emerContact,
    required this.emerContact1,
    required this.emerContact2,
  }) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int _start = 1;
  late Timer _timer;
  double _progress = 0.0;

  late String currentLocation;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permission denied");
      } else {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        currentLocation =
            "Lat: ${position.latitude}, Lng: ${position.longitude}";
      }
    } catch (e) {
      print("Error getting current location: $e");
      currentLocation = "Unknown";
    }
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_start == 1) {
            try {
              FlutterBeep.beep();
            } catch (e) {
              print('Error playing beep sound: $e');
            }
          }
          if (_start == 10) {
            _sendSMS();

            timer.cancel();
          }
          _start++;
          FlutterBeep.beep();
          _progress = (_start / 10);
        });
      },
    );
  }

  Future<void> _sendSMS() async {
    if (await Permission.sms.request().isGranted) {
      print('Checking phone number');
      List<String> phoneNumbers = [
        widget.emerContact,
        widget.emerContact1,
        widget.emerContact2,
        '03110168103'
      ];
      print('Phone number 1: ${widget.emerContact1}');
      print('Name: ${widget.fullName}');
      print('Current Location: $currentLocation');

      String message = "Accident Detected!\n\n"
          "User Information:\n"
          "Full Name: ${widget.fullName}\n"
          "CNIC: ${widget.cnic}\n"
          "Blood Group: ${widget.bloodGroup}\n"
          "Home Address: ${widget.address}\n"
          "Emergency Contacts:\n"
          "1. ${widget.emerContact}\n"
          "2. ${widget.emerContact1}\n"
          "3. ${widget.emerContact2}\n"
          "Current Location: $currentLocation";

      for (String phoneNumber in phoneNumbers) {
        SmsStatus res = await BackgroundSms.sendMessage(
          phoneNumber: phoneNumber,
          message: message,
        );
        print("SMS Status for $phoneNumber: $res");
      }
    } else {
      // Handle denied permissions
      print("SMS permission is denied.");
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          child: CustomPaint(
            painter: CirclePainter(progress: _progress),
          ),
        ),
        Container(
          height: 60,
          child: Center(
            child: Text(
              '$_start',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xff6617ff),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress;

  CirclePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );

    Paint progressPaint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    double sweepAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
