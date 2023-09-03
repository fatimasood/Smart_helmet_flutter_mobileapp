import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'SignIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _passwordVisible = false; //for password visibility toggle

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffDDE6ED),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SMART",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "HELMET",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
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
                    left: 35.0,
                    top: 0.0 + 50,
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
              SizedBox(height: 31),
              buildInputField(
                hintText: 'Full name',
                prefixIcon: Icons.person_2_outlined,
              ),
              SizedBox(height: 22),
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
              SizedBox(height: 50),
              SizedBox(
                height: 40,
                width: 140,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffc780ff),
                  ),
                  child: Text(
                    "Sign up",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
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
              SizedBox(height: 15),
              Text(
                '────── or ──────',
                style: GoogleFonts.inknutAntiqua(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff6617ff),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildSocialIcon(imagePath: "lib/assets/fb.png"),
                  SizedBox(width: 10),
                  buildSocialIcon(imagePath: "lib/assets/google.png"),
                ],
              ),
              SizedBox(height: 75),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
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
                        ),
                      );
                    },
                    child: Text(
                      'Log in',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
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
