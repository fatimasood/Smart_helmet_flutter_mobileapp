import 'package:flutter/material.dart';
import 'package:fypprojectp/screens/SignUp.dart';
import 'package:fypprojectp/screens/ThirdScreen.dart';

import 'SecondScreen.dart';
import 'firstScreen.dart';

class PageSlider extends StatefulWidget {
  PageSlider() : super();

  @override
  State<PageSlider> createState() => _PageSliderState();
}

class _PageSliderState extends State<PageSlider> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: [
          firstScreen(),
          SecondScreen(),
          ThirdScreen(),
          SignUp(),
        ],
      ),
    );
  }
}
