import 'package:flutter/material.dart';

import 'AccountScreen.dart';
import 'HomeScreen.dart';
import 'LearnScreen.dart';
import 'NavigationScreens/bottomNavigation.dart';
import 'NavigationScreens/customAppbar.dart';
import 'NavigationScreens/customSidebar.dart';
import 'SignsScreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    HomeScreen(),
    LearnScreen(),
    SignsScreen(),
    AccountScreen(),
  ];

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void _onSidebarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
    Navigator.pop(context); // Close the sidebar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: CustomAppBar(
        height: 170,
      ), // Adjust the height as needed

      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onBottomNavItemTapped,
      ),
      drawer: CustomSidebar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onSidebarItemTapped,
      ),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
