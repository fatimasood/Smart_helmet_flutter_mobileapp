import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fypprojectp/screens/SplashScreens.dart';
import 'package:fypprojectp/screens/Sqflite/DatabaseHelper.dart';

String? mail_address;
String? savedEmailA;
String? email;
String? mail;
String? userMail;
String _logout = "login";
String dataSaved = '';
String? phonenum1 = '';
String? phonenum2 = '';
String? phonenum3 = '';
String? user_name = '', user_cnic = '', user_bGroup = '', user_Address = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  DatabaseHelper databaseHelper = DatabaseHelper(); //initialize Database sql
  await databaseHelper.initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Helmet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const EditInformation(),
      home: const SplashScreen(title: 'Smart Helmet'),
    );
  }
}
