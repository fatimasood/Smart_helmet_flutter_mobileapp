import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'SignIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _passwordVisible = false; //for password state saving
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffDDE6ED),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  "SMART",
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  "HELMET",
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Color(0xffc780ff),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 35.0, right: 0, bottom: 8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Create",
                          style: GoogleFonts.jomhuria(
                            textStyle: const TextStyle(
                              fontSize: 67,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff6617ff),
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  offset: Offset(1, 6),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 25.0,
                  top: 0.0 + 50, // Adjust this value to overlap the text
                  child: Text(
                    "Account",
                    style: GoogleFonts.jomhuria(
                      textStyle: const TextStyle(
                        fontSize: 67,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff6617ff),
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(1, 6),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 31,
            ),
            Positioned(
              // group2FRT (12:44)
              left: 31,
              top: 299,
              child: Container(
                padding: EdgeInsets.fromLTRB(12, 12, 21, 9),
                width: 326,
                height: 42,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0, 4),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 11.0),
                    border: InputBorder.none,
                    hintText: 'Full name',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffc780ff),
                    ),
                    prefixIcon: Icon(
                      Icons.person_2_outlined,
                      size: 20,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Positioned(
              // group2FRT (12:44)
              left: 31,
              top: 299,
              child: Container(
                padding: EdgeInsets.fromLTRB(12, 12, 21, 9),
                width: 326,
                height: 42,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0, 4),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 11.0),
                    border: InputBorder.none,
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffc780ff),
                    ),
                    prefixIcon: Icon(
                      Icons.mail_outline_rounded,
                      size: 20,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Positioned(
              // group2FRT (12:44)
              left: 31,
              top: 299,
              child: Container(
                padding: EdgeInsets.fromLTRB(12, 12, 21, 9),
                width: 326,
                height: 42,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0, 4),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: TextField(
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 11.0),
                    border: InputBorder.none,
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      padding: EdgeInsets.only(bottom: 11.0),
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black45,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffc780ff),
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 20,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: SizedBox(
                height: 40,
                width: 140,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffc780ff),
                    // Set the button color to purple
                  ),
                  child: Text(
                    "Sign up",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffdde6ed),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 10,
              height: 20,
            ),
            Text(
              '────── or ──────',
              style: GoogleFonts.inknutAntiqua(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xff6617ff),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(
                      "lib/assets/fb.png",
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Align(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(
                      "lib/assets/google.png",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 75,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Already have an account? ',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff6617ff),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ), // Replace SignIn with the actual name of your sign-in screen widget
                        );
                      },
                      child: Text(
                        'log in',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff6617ff),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
