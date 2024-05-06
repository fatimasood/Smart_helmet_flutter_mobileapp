import 'dart:async';

import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:permission_handler/permission_handler.dart';

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int _start = 1;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 1) {
          try {
            FlutterBeep.beep();
          } catch (e) {
            print('Error playing beep sound: $e');
          }
        }
        if (_start == 5) {
          _sendSMS();
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start++;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Center(
        child: Text(
          '$_start',
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: Colors.red.shade700,
          ),
        ),
      ),
    );
  }

  Future<void> _sendSMS() async {
    if (await Permission.sms.request().isGranted) {
      List<String> phoneNumbers = [
        "03110168103",
        "03115199742"
      ]; // recipient's numbers
      String message = "Accident Detected!"; //message

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
}
