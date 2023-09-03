import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  CustomAppBar({this.height = kToolbarHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Color(0xffc780ff),
      ),
      child: Builder(
        builder: (context) {
          return IconButton(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(top: 45.0, bottom: 30.0, right: 20.0),
            icon: Icon(
              Icons.menu,
              color: Colors.white54,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
