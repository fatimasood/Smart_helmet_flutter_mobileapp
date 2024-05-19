import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignsScreen extends StatefulWidget {
  const SignsScreen({Key? key}) : super(key: key);

  @override
  State<SignsScreen> createState() => _SignsScreenState();
}

class _SignsScreenState extends State<SignsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Motorcycle Safety Checklist',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff6617ff),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Image.asset(
                    "lib/assets/rideimage1.png",
                    width: 370,
                    height: 200,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Image.asset(
                    "lib/assets/rideimage2.png",
                    width: 370,
                    height: 200,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Image.asset(
                    "lib/assets/rideImage3.png",
                    width: 390,
                    height: 260,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
