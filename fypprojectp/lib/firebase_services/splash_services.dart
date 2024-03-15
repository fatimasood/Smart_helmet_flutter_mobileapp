import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fypprojectp/screens/Authentication/SignIn.dart';
import 'package:fypprojectp/screens/home.dart';

String? savedEmailA;

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      //saved email address of user if usrer is logged in
      savedEmailA = user.email;
      print('(SS)loggedin Mail address is: ${savedEmailA}');

      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home())));
    } else {
      Timer(
          const Duration(seconds: 6),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignIn())));
    }
  }
}
