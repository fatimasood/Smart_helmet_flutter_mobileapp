import 'package:flutter/material.dart';

class CustomSidebar extends StatelessWidget {
  const CustomSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 559,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Color(0xffd7c3ff),
      ),
      child: Column(
        children: [
          DrawerHeader(
            child: Builder(
              builder: (context) {
                return IconButton(
                  alignment: Alignment.bottomRight,
                  padding:
                      EdgeInsets.only(top: 25.0, bottom: 90.0, right: 20.0),
                  icon: Icon(
                    Icons.close,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the sidebar
                  },
                );
              },
            ),
            decoration: BoxDecoration(
              color: Color(0xffd7c3ff),
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              Navigator.pop(context); // Close the sidebar
            },
          ),
          ListTile(
            selectedTileColor: Colors.white54,
            leading: Icon(
              Icons.home,
              size: 20,
              color: Colors.white,
            ),
            title: Text(
              "Order",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onTap: () {
              //move to next screen
            },
          ),
          ListTile(
            title: Text('Item 3'),
            onTap: () {
              Navigator.pop(context); // Close the sidebar
            },
          ),
          ListTile(
            title: Text('Item 4'),
            onTap: () {
              Navigator.pop(context); // Close the sidebar
            },
          ),
        ],
      ),
    );
  }
}
