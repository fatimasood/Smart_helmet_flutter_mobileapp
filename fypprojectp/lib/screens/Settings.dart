import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fypprojectp/screens/Authentication/SignIn.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var _ratingController = TextEditingController();
  var _feedbackController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    _ratingController.text = "3.0";
    super.initState();
  }

  Future<void> _signOut() async {
    await _auth.signOut();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }

  Future<void> _feedback() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            " Help us shine brighter! ",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff6617ff),
                fontWeight: FontWeight.w600,
                fontSize: 17),
          ),
          content: Container(
            height: 250,
            child: Column(
              children: [
                RatingBar.builder(
                  unratedColor: Colors.grey[400],
                  itemSize: 35,
                  glow: false,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    if (rating.toInt() < 3) {
                      log("less than 3");
                    } else {
                      log("greater than 3");
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Share your thoughts here... ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color(0xff6617ff),
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
                SizedBox(
                  height: 13,
                ),
                Container(
                  width: 200.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Color(0xff6617ff),
                      width: 1.0,
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _feedbackController,
                        style: TextStyle(
                            color: Color(0xffa678ff),
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Get feedback text
                String feedbackText = _feedbackController.text;

                print("Feedback Text: $feedbackText");

                Navigator.of(context).pop();
              },
              child: Text(
                'Submit',
                style: TextStyle(
                    color: Color(0xff6617ff),
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _contactUs(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text(
            'Hey! How can we help you.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff6617ff),
                fontWeight: FontWeight.w600,
                fontSize: 17),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _launchMail('205366@aack.au.edu.pk');
                  },
                  child: Text(
                    '205366@aack.au.edu.pk',
                    style: TextStyle(
                        color: Color(0xff6617ff),
                        fontWeight: FontWeight.w400,
                        fontSize: 12.5),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    _launchMail('205366@aack.au.edu.pk');
                  },
                  child: Text(
                    '205366@aack.au.edu.pk',
                    style: TextStyle(
                        color: Color(0xff6617ff),
                        fontWeight: FontWeight.w400,
                        fontSize: 12.5),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    _launchMail('205366@aack.au.edu.pk');
                  },
                  child: Text(
                    '205366@aack.au.edu.pk',
                    style: TextStyle(
                        color: Color(0xff6617ff),
                        fontWeight: FontWeight.w400,
                        fontSize: 12.5),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(
                    color: Color(0xff6617ff),
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            ),
          ],
        );
      },
    );
  }

  void _launchMail(String email) async {
    String subject = 'Help Required!';
    String mailUrl = 'mailto:$email?subject=${Uri.encodeComponent(subject)}';
    if (await canLaunch(mailUrl)) {
      await launch(mailUrl);
    } else {
      throw 'Could not launch $mailUrl';
    }
  }

  Future<void> _tutorial() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 25),
          child: Column(
            children: [
              InkWell(
                onTap: _tutorial,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 50,
                    color: Color(0xffede5fd),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, bottom: 10, right: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.help_center_outlined,
                            color: Color(0xffa678ff),
                            size: 16.5,
                          ),
                          SizedBox(
                            width: 8.5,
                          ),
                          Text(
                            'Tutorial and Help',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffa678ff),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 13,
              ),
              InkWell(
                onTap: () {
                  _contactUs(context);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 50,
                    color: Color(0xffede5fd),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, bottom: 10, right: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.mail_outline_sharp,
                            color: Color(0xffa678ff),
                            size: 16.5,
                          ),
                          SizedBox(
                            width: 8.5,
                          ),
                          Text(
                            'Contact US',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffa678ff),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 13,
              ),
              InkWell(
                onTap: _feedback,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 50,
                    color: Color(0xffede5fd),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, bottom: 10, right: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.feedback_outlined,
                            color: Color(0xffa678ff),
                            size: 16.5,
                          ),
                          SizedBox(
                            width: 8.5,
                          ),
                          Text(
                            'Feedback',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffa678ff),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 13,
              ),
              InkWell(
                onTap: _signOut,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 50,
                    color: Color(0xffede5fd),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, bottom: 10, right: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout_outlined,
                            color: Color(0xffa678ff),
                            size: 16.5,
                          ),
                          SizedBox(
                            width: 8.5,
                          ),
                          Text(
                            'Logout',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffa678ff),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
