import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fypprojectp/screens/Authentication/SignUp.dart';
import 'package:fypprojectp/screens/Sqflite/DatabaseHelper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'EditInformation.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<UserRecord> userRecord = [];

  @override
  void initState() {
    super.initState();
    _loadUserRecords();
  }

  Future<void> _loadUserRecords() async {
    String? mail;
    mail = userMail;
    try {
      if (mail == userMail) {
        print('mail $mail');

        final records =
            await _databaseHelper.getAllUserRecordForUser(userMail!);
        print('Records loaded successfully: $records');

        setState(() {
          userRecord = records;
        });
      }
    } catch (e) {
      print('Error loading user records: $e');
    }
  }

//Image

  ImageProvider imageProviderFromBytes(Uint8List bytes) {
    return MemoryImage(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                for (var record in userRecord)
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 10, bottom: 3, right: 10),
                    child: CircleAvatar(
                      radius: 35.0,
                      backgroundColor: Color(0xffede5fd),
                      child: ClipOval(
                        child: Image(
                          image: imageProviderFromBytes(
                              record.imageBytes), // Use the correct field
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var record in userRecord)
                      Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              '${record.fullName.capitalize}',
                              style: TextStyle(
                                  color: Color(0xff9d6bff),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    GestureDetector(
                      onTap: navigateToEditInformationScreen,
                      child: Row(
                        children: [
                          Text(
                            "Edit Information",
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: Color(0xff9d6bff),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 180, 147, 247),
                            size: 17,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 350,
              child: Center(
                child: Divider(
                  height: 18.5,
                  thickness: 2.0,
                  color: Color(0xff6617ff).withOpacity(0.1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Personal Information",
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff6617ff),
                  ),
                ),
              ),
            ),
            Container(
              height: 340,
              width: 340,
              decoration: BoxDecoration(
                color: Color(0xffede5fd),
                borderRadius: BorderRadius.all(Radius.circular(35)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffa678ff),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "CNIC",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffa678ff),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Blood Group",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffa678ff),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "SOS Contacts",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffa678ff),
                            ),
                          ),
                        ),
                        SizedBox(height: 61),
                        Text(
                          "Address",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffa678ff),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 2.0,
                      height: double.infinity,
                      color: Color(0xff6617ff).withOpacity(0.1),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    for (var record in userRecord)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${record.fullName}',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffa678ff),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${record.cnic}',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffa678ff),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${record.bloodGroup}',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffa678ff),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${record.emerContact}',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffa678ff),
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            '${record.emeContact}',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffa678ff),
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            '${record.emContact}',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffa678ff),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: 145,
                            child: Text(
                              '${record.address}',
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffa678ff),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToEditInformationScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditInformation()));
  }
}
