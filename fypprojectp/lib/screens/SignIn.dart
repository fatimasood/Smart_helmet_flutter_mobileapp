import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;
  final _auth = FirebaseAuth.instance;

  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '\aKindly Enter Valid mail';
                          }
                          if (!value.endsWith('@gmail.com')) {
                            return 'Kindly Enter Valid mail';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 22),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: SizedBox(
                    height: 40,
                    width: 140,
                    child: InkWell(
                      // onTap: onTap(){},
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
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ),
                            );
                          } else {}
                        },
                      ),
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
