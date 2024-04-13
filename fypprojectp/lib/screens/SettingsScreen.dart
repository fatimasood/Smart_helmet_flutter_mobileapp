import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fypprojectp/main.dart';
import 'package:fypprojectp/screens/Authentication/SignIn.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    await _auth.signOut();

    print('userMail is $userMail');
    print('mail is $mail');
    print('email is $email');
    print('savedEmailA is $savedEmailA');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9d6bff),
        title: Text(
          'Settings',
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 16,
          ),
          onPressed: () {
            Navigator.of(context).pop(); //close current screen
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 25),
          child: Column(
            children: [
              InkWell(
                onTap: _signOut,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 50,
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, bottom: 10, right: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.help_center_outlined,
                            color: Colors.black,
                            size: 18,
                          ),
                          SizedBox(
                            width: 8.5,
                          ),
                          Text(
                            'Tutorial and Help',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
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
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, bottom: 10, right: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.feed_outlined,
                            color: Colors.black,
                            size: 18,
                          ),
                          SizedBox(
                            width: 8.5,
                          ),
                          Text(
                            'About and Legal Information',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
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
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, bottom: 10, right: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.feedback_outlined,
                            color: Colors.black,
                            size: 18,
                          ),
                          SizedBox(
                            width: 8.5,
                          ),
                          Text(
                            'Feedback',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
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
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, bottom: 10, right: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout_outlined,
                            color: Colors.black,
                            size: 18,
                          ),
                          SizedBox(
                            width: 8.5,
                          ),
                          Text(
                            'Logout',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
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
