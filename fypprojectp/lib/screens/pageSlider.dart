import 'package:flutter/material.dart';
import 'package:fypprojectp/screens/ThirdScreen.dart';

import 'SecondScreen.dart';
import 'firstScreen.dart';

class PageSlider extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal, // Set the scroll direction as needed
        children: [
          firstScreen(),
          SecondScreen(),
          ThirdScreen(),
          // Add more screens if needed
        ],
      ),
    );
  }
}
