import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: 350,
              child: Text(
                'Learning to ride a motorcycle can be fun. The best way to learn how to properly ride is in a safe and controlled manner. Always practice safety first and be sure you have appropriate safety gear for the type of riding you will do. Beginners can enroll in motorcycle safety courses that give you the tools to be a proper rider. ',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff9d6bff),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 150,
            height: 150,
            child: Image(
              image: AssetImage('lib/assets/helmet.png'),
            ),
          ),
          Container(
            width: 350,
            child: Text(
              'Get a helmet. Your motorcycle helmet is  most important piece of equipment for motorcycling riding. It protects your head from injury in the event that your motorcycle goes down. For it to do its job, the helmet must fit well, while maintaining your field of vision. The best helmet for you is an individual thing  ',
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff9d6bff),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
