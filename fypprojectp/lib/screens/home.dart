import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'AccountScreen.dart';
import 'HomeScreen.dart';
import 'LearnScreen.dart';
import 'SignsScreen.dart';
import 'bottomNavigation.dart';
import 'customAppbar.dart';
import 'customSidebar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int _selectedIndex = 0;

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
  }

  void _onDrawerNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        height: 170,
      ), // Adjust the height as needed

      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onBottomNavItemTapped,
      ),
      drawer: CustomSidebar(),
    );
  }
}
