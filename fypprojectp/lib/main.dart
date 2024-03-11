import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fypprojectp/screens/Authentication/SignIn.dart';
import 'package:fypprojectp/screens/SplashScreens.dart';
import 'package:fypprojectp/screens/Sqflite/DatabaseHelper.dart';
import 'package:fypprojectp/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  DatabaseHelper databaseHelper = DatabaseHelper(); //initialize Database sql
  await databaseHelper.initializeDatabase();
  final savedUserId = await getSavedUserId() ?? '';
  runApp(MyApp(savedUserId: savedUserId));
}

Future<void> persistLogin(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('userId', userId);
}

Future<String?> getSavedUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId');
}

class MyApp extends StatelessWidget {
  final String? savedUserId;
  MyApp({required this.savedUserId});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Helmet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const SplashScreen(title: 'Smart Helmet'),
      home: FutureBuilder(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen(title: 'Smart Helmet');
          } else {
            if (snapshot.hasData || savedUserId != null) {
              return Home();
            } else {
              return SignIn();
            }
          }
        },
      ),
    );
  }
}
