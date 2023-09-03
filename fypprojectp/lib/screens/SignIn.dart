import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'SignUp.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _passwordVisible = false; //for password state saving

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffDDE6ED),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  SizedBox(
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
                            "Welcome",
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
                    left: 35.0,
                    top: 0.0 + 50,
                    child: Text(
                      "Back",
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
                height: 61,
              ),
              buildInputField(
                hintText: 'Email',
                prefixIcon: Icons.mail_outline_rounded,
              ),
              SizedBox(height: 22),
              buildInputField(
                hintText: 'Password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
              ),
              Padding(
                padding: EdgeInsets.only(top: 70),
                child: SizedBox(
                  height: 40,
                  width: 140,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffc780ff),
                      // Set the button color to purple
                    ),
                    child: Text(
                      "Log in",
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
                          builder: (context) => Home(),
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
                'Forget password?',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff9d6bff),
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
                height: 155,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "Don't have an account? ",
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
                              builder: (context) => SignUp(),
                            ), // Replace SignIn with the actual name of your sign-in screen widget
                          );
                        },
                        child: Text(
                          'Sign up',
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
      ),
    );
  }

  Widget buildInputField({
    required String hintText,
    required IconData prefixIcon,
    bool isPassword = false,
  }) {
    return Container(
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
        obscureText: isPassword && !_passwordVisible,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 11.0),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xffc780ff),
          ),
          prefixIcon: Icon(
            prefixIcon,
            size: 20,
            color: Colors.black45,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  padding: EdgeInsets.only(bottom: 11.0),
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black45,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }

  Widget buildSocialIcon({required String imagePath}) {
    return Align(
      child: SizedBox(
        width: 50,
        height: 50,
        child: Image.asset(
          imagePath,
        ),
      ),
    );
  }
}
