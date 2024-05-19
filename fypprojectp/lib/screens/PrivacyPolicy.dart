import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class privacypolicy extends StatefulWidget {
  const privacypolicy({super.key});

  @override
  State<privacypolicy> createState() => _privacypolicyState();
}

class _privacypolicyState extends State<privacypolicy> {
  void _close() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffede5fd),
      appBar: AppBar(
        backgroundColor:
            Color(0xffa678ff), // Purple color used for text in "About US"
        title: Text(
          'About US',
          style: TextStyle(color: Color(0xffede5fd)), // White color for text
        ),
        leading: IconButton(
          onPressed: _close,
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Color(0xffede5fd), // White color for icon
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 100,
                width: 100,
                child: Image.asset("lib/assets/Person1.png"),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Fatima Masood',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xffa678ff),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 7, left: 17, right: 17, bottom: 0),
              child: Text(
                "Fatima is a Mobile App Developer. In this project she works on application develop on flutter framework so it is available for both android and ios mobile phones. ",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffa678ff),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 100,
                width: 100,
                child: Image.asset("lib/assets/Person1.png"),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Huzaifa Hafeez',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xffa678ff),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 7, left: 17, right: 17, bottom: 0),
              child: Text(
                "Huzaifa is a Team Leader. He is a graphic Designer and a Developer. Company Named Hexler Solution's CO-FOUNDER and a successfull freelancer. In this project he work on Hardware and complete Documentation. ",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffa678ff),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 100,
                width: 100,
                child: Image.asset("lib/assets/Person1.png"),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Muzammil Shoukat',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xffa678ff),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 7, left: 17, right: 17, bottom: 0),
              child: Text(
                "He is a graphic Designer and a Developer. Company Named Hexler Solution's CO-FOUNDER and a successfull freelancer. In this project he work on Hardware and Documentation. ",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffa678ff),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
