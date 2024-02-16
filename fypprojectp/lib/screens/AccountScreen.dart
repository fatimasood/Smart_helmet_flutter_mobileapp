import 'package:flutter/material.dart';
import 'package:fypprojectp/screens/NavigationScreens/SignUp.dart';
import 'package:fypprojectp/screens/Sqflite/DatabaseHelper.dart';
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
    try {
      String? loggedInUserEmail = userMail;
      print('loggedInUserEmail: $loggedInUserEmail');

      if (loggedInUserEmail != null) {
        String loggedInUserName = loggedInUserEmail.split('@').first;
        print('loggedInUserName: $loggedInUserName');

        final records =
            await _databaseHelper.getAllUserRecordForUser(loggedInUserName);
        print('Records loaded successfully: $records');

        setState(() {
          userRecord = records;
        });
      }
    } catch (e) {
      print('Error loading user records: $e');
    }
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, bottom: 3, right: 10),
                  child: CircleAvatar(
                    radius: 35.0,
                    backgroundColor: Color(0xffede5fd),
                    child: Icon(
                      Icons.person,
                      size: 40,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var record in userRecord)
                      Container(
                        width: 200,
                        height: 90,
                        decoration: BoxDecoration(color: Colors.white),
                        child: ListTile(
                          title: Text(
                            '${record.fullName}',
                            style: TextStyle(color: Color(0xff9d6bff)),
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
                          "Address",
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
                      ],
                    ),
                    Container(
                      width: 2.0,
                      height: double.infinity,
                      color: Color(0xff6617ff).withOpacity(0.1),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "John",
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
                          "22398-7593793-9",
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
                          "A+",
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
                          "Attock City",
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
                          "37567567667",
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
                          "03756746776",
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
                          "03756746776",
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
                          "03756746776",
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
