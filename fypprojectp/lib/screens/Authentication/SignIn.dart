import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fypprojectp/main.dart';
import 'package:fypprojectp/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home.dart';
import 'SignUp.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isPasswordVisible = false; //for password state saving

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final resetEmailController = TextEditingController();

  bool loading = false;
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    resetEmailController.dispose();
  }

  Future<void> _resetPassword() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Password Update",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff6617ff),
                fontWeight: FontWeight.w800,
                fontSize: 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Write your Email to send reset link',
                style: TextStyle(color: Color(0xffc780ff)),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0, 4),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: resetEmailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    hintStyle: TextStyle(
                        fontSize: 12,
                        color: Color(0xffc780ff),
                        fontStyle: FontStyle.normal),
                    prefixIcon: Icon(
                      Icons.mail_outline_rounded,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.endsWith('@gmail.com')) {
                      return 'Kindly enter a proper Gmail address';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          actions: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffc780ff),
                    ),
                    onPressed: () {
                      if (resetEmailController.text.isEmpty ||
                          !resetEmailController.text.endsWith('@gmail.com')) {
                        Fluttertoast.showToast(
                          msg: 'Please enter a valid Gmail address',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.deepPurple,
                          textColor: Colors.white54,
                          fontSize: 16.0,
                        );
                        return;
                      }

                      _auth
                          .sendPasswordResetEmail(
                              email: resetEmailController.text.toString())
                          .then((value) {
                        Fluttertoast.showToast(
                          msg: 'Password reset email sent',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.deepPurple,
                          textColor: Colors.white54,
                          fontSize: 16.0,
                        );
                        Navigator.pop(context);
                      }).catchError((error) {
                        Fluttertoast.showToast(
                          msg: error.toString(),
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.deepPurple,
                          textColor: Colors.white54,
                          fontSize: 16.0,
                        );
                      });
                    },
                    child: Text(
                      "Reset",
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffdde6ed),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void login() {
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      userMail = emailController.text;

      print('login user mail: $userMail');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    });
  }

  @override
  void initState() {
    super.initState();
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
                const SizedBox(
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
                      buildInputField(
                        hintText: 'Email',
                        prefixIcon: Icons.mail_outline_rounded,
                      ),
                      const SizedBox(height: 12),
                      buildInputField(
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        onTogglePassword: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
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
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xffc780ff),
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
                            login();
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
                GestureDetector(
                  onTap: () {
                    _resetPassword();
                  },
                  child: Text(
                    'Forget password?',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff9d6bff),
                      ),
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
                              color: const Color(0xff66117ff),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ),
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
    Function? onTogglePassword,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 21, 9),
      child: Container(
        width: 326,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3f000000),
              offset: Offset(0, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: TextFormField(
          keyboardType: isPassword
              ? TextInputType.visiblePassword
              : TextInputType.emailAddress,
          controller: isPassword ? passwordController : emailController,
          obscureText: isPassword && !_isPasswordVisible,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 11.28),
            hintText: hintText,
            hintStyle: const TextStyle(
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
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  )
                : null,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              Fluttertoast.showToast(
                msg: isPassword
                    ? 'Please enter a password'
                    : 'Please enter a valid email',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.deepPurple,
                textColor: Colors.white54,
                fontSize: 16.0,
              );
              return null;
              //play sound
              //_audioPlayer.play('assets/beep.mp3', isLocal: true');
            }
            if (isPassword && value.length < 6) {
              Fluttertoast.showToast(
                msg: 'Password should be at least 6 characters long',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.deepPurple,
                textColor: Colors.white54,
                fontSize: 16.0,
              );
              return null;
              // Play the beep sound
              //  await _audioPlayer.play('assets/beep.mp3', isLocal: true);
            }
            if (!isPassword && !value.endsWith('@gmail.com')) {
              Fluttertoast.showToast(
                msg: 'Kindly Enter Proper mail',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.deepPurple,
                textColor: Colors.white54,
                fontSize: 16.0,
              );
              // Play the beep sound
              // await _audioPlayer.play('assets/beep.mp3', isLocal: true);
            }
            return null;
          },
        ),
      ),
    );
  }
}
