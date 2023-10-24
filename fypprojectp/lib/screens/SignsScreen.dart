import 'package:flutter/material.dart';

class SignsScreen extends StatefulWidget {
  const SignsScreen({super.key});

  @override
  State<SignsScreen> createState() => _SignsScreenState();
}

class _SignsScreenState extends State<SignsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 15),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  child: Image.asset('lib/assets/pic1.png'),
                ),
                Container(
                  width: 120,
                  height: 120,
                  child: Image.asset('lib/assets/pic2.png'),
                ),
                Container(
                  width: 120,
                  height: 120,
                  child: Image.asset('lib/assets/pic3.png'),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 120,
                height: 120,
                child: Image.asset('lib/assets/pic4.png'),
              ),
              Container(
                width: 120,
                height: 120,
                child: Image.asset('lib/assets/pic5.png'),
              ),
              Container(
                width: 120,
                height: 120,
                child: Image.asset('lib/assets/pic6.png'),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
