import 'dart:async';
import 'dart:math';

import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:fypprojectp/main.dart';
import 'package:permission_handler/permission_handler.dart';

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int _start = 1;
  late Timer _timer;
  double _progress = 0.0;

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
        setState(() {
          if (_start == 1) {
            try {
              FlutterBeep.beep();
            } catch (e) {
              print('Error playing beep sound: $e');
            }
          }
          if (_start == 10) {
            timer.cancel();
            _sendSMS(); // send SMS
          }
          _start++;
          FlutterBeep.beep();
          _progress = (_start / 5);
        });
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

  Future<void> _sendSMS() async {
    if (await Permission.sms.request().isGranted) {
      List<String> phoneNumbers = [
        phonenum1.toString(),
        phonenum2.toString(),
        phonenum3.toString(),
        //"923200594810"
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
