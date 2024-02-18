import 'package:flutter/material.dart';
import 'package:fypprojectp/screens/Authentication/SignUp.dart';
import 'package:page_transition/page_transition.dart';

import 'ThirdScreen.dart';

// ignore: camel_case_types
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30.0),
          ),
          Container(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SMART",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      height: 1.2125 * 2.0 / 1.0,
                      fontFamily: 'Inter',
                      color: Colors.black),
                ),
                SizedBox(
                  width: 7.0,
                ),
                Text(
                  "HELMET",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      height: 1.2125 * 2.0 / 1.0,
                      fontFamily: 'Inter',
                      color: Color(0xffc780ff)),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 65.0)),
                Image.asset(
                  "lib/assets/Saly-31.png",
                  width: 300,
                  height: 300,
                ),
                Container(
                  // howourapplicationworksDeh (2:23)
                  padding: const EdgeInsets.only(top: 15.0),
                  child: const Text(
                    'Emergency Notifications',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1.2125 * 2.0 / 1.0,
                      fontFamily: 'Inter',
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Container(
                  // loremipsumissimplydummytextoft (2:24)
                  margin: const EdgeInsets.fromLTRB(
                      0 * 1.5, 0 * 1.5, 1 * 1.5, 18 * 1.5),
                  constraints: const BoxConstraints(
                    maxWidth: 303 * 1.0,
                  ),
                  child: const Text(
                    'Intuitive interface for effortless use."\n"Simplified design for smooth interaction.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w100,
                      height: 1.4125,
                      fontFamily: 'Inter',
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // ellipse4L7s (2:32)
                      margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color(0xffd7c3ff),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                      width: 37,
                      height: 14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: const Color(0xff9d6bff),
                      ),
                    ),
                    Container(
                      // ellipse53HB (2:33)
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color(0xffd7c3ff),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 90.0),
                  width: double.infinity,
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: SignUp()));
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 27.0, top: 17.0),
                            child: Text(
                              'Skip',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 1.2125 * 2.0 / 1.0,
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: ThirdScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 16.0), // Adjust the spacing as needed
                          child: Container(
                            width: 43 * 1.5,
                            height: 43 * 1.5,
                            decoration: BoxDecoration(
                              color: const Color(0xff8048ec),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x3f000000),
                                  offset: Offset(0 * 1.5, 4 * 1.5),
                                  blurRadius: 2 * 1.5,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_forward, // Right arrow icon
                                size: 30.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
