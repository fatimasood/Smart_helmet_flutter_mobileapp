import 'package:flutter/material.dart';
import 'package:fypprojectp/screens/EntryScreens/ThirdScreen.dart';
import 'package:fypprojectp/screens/Authentication/SignUp.dart';

import '../EntryScreens/SecondScreen.dart';
import '../EntryScreens/firstScreen.dart';

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
