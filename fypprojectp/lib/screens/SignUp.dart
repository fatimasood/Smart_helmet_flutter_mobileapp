import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fypprojectp/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'SignIn.dart';
// Import the InputTextField widget

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _passwordVisible = false; //for password visibility toggle
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();

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
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildInputField(
                          controller: fullNameController,
                          hintText: 'Full name',
                          prefixIcon: Icons.person_2_outlined,
                          isNameField: true,
                        ),
                        SizedBox(height: 7),
                        buildInputField(
                          hintText: 'Email',
                          prefixIcon: Icons.mail_outline_rounded,
                          controller: emailController,
                        ),
                        SizedBox(height: 7),
                        buildInputField(
                          controller: passwordController,
                          hintText: 'Password',
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          onTogglePassword: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
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
                      ],
                    )),
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

  Widget buildInputField({
    required String hintText,
    required IconData prefixIcon,
    bool isPassword = false,
    Function? onTogglePassword,
    required TextEditingController controller,
    bool isNameField = false, // Add this flag
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 12, 21, 9),
      child: Container(
        width: 326,
        height: 50,
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
        child: TextFormField(
          keyboardType: isPassword
              ? TextInputType.visiblePassword
              : TextInputType.emailAddress,
          controller: controller,
          obscureText: isPassword && !_passwordVisible,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 11.28),
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
            border: InputBorder.none,
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: () {
                      if (onTogglePassword != null) {
                        onTogglePassword();
                      }
                    },
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  )
                : null,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return isPassword
                  ? 'Please enter a password'
                  : isNameField
                      ? 'Please enter your full name'
                      : 'Please enter a valid email';
            }
            if (isPassword && value.length < 6) {
              return 'Password should be at least 6 characters long';
            }
            if (!isPassword && !value.endsWith('@gmail.com')) {
              return 'Please enter your gmail';
            }
            return null;
          },
        ),
      ),
    );
  }

  bool _areAllFieldsValid() {
    return _formKey.currentState!.validate();
  }
}
