import 'package:flutter/material.dart';
import 'package:fypprojectp/main.dart';
import 'package:google_fonts/google_fonts.dart';

class BluetoothConnectedScreen extends StatefulWidget {
  final String data;
  const BluetoothConnectedScreen({Key? key, required this.data})
      : super(key: key);

  @override
  State<BluetoothConnectedScreen> createState() =>
      _BluetoothConnectedScreenState();
}

class _BluetoothConnectedScreenState extends State<BluetoothConnectedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9d6bff),
        title: Text(
          '',
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 16,
          ),
          onPressed: () {
            Navigator.of(context).pop(); //close current screen
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 25),
          child: Center(
            child: Text(
              'Data received: $dataSaved',
              style: TextStyle(color: Colors.purple),
            ),
          ), // Display received data
        ),
      ),
    );
  }
}
