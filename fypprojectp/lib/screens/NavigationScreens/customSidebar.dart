import 'package:flutter/material.dart';

class CustomSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomSidebar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 520,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
        color: Color(0xff9d6bff),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.zero,
            child: Builder(
              builder: (context) {
                return IconButton(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 20.0, bottom: 0.0, right: 20.0),
                  icon: Icon(
                    Icons.close,
                    color: Color.fromARGB(237, 255, 255, 255),
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the sidebar
                  },
                );
              },
            ),
            decoration: BoxDecoration(
              color: Color(0xff9d6bff),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Container(
              height: 40,
              child: ListTile(
                title: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    color: Color(0xffffffff),
                  ),
                ),
                onTap: () {
                  onItemTapped(0); // Navigate to the screen
                },
                leading: Icon(
                  Icons.home_filled,
                  size: 25,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: Container(
              height: 40,
              child: ListTile(
                title: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    color: Color(0xffffffff),
                  ),
                ),
                onTap: () {
                  onItemTapped(1); // Navigate to the screen
                },
                leading: Icon(
                  Icons.person_4_rounded,
                  size: 25,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: Container(
              height: 40,
              child: ListTile(
                title: Text(
                  'Signs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    color: Color(0xffffffff),
                  ),
                ),
                onTap: () {
                  onItemTapped(2); // Navigate to the screen
                },
                leading: Icon(
                  Icons.sign_language,
                  size: 25,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: Container(
              height: 40,
              child: ListTile(
                title: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    color: Color(0xffffffff),
                  ),
                ),
                onTap: () {
                  onItemTapped(3); // Navigate to the screen
                },
                leading: Icon(
                  Icons.settings,
                  size: 25,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 200),
            child: Container(
              height: 40,
              child: ListTile(
                title: Text(
                  'About us',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    color: Color(0xffffffff),
                  ),
                ),
                onTap: () {
                  // Navigate to the settings screen
                },
                leading: Icon(
                  Icons.info,
                  size: 25,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
