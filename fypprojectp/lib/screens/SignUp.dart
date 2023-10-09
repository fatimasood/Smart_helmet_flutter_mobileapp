import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fypprojectp/screens/home.dart';
import 'package:fypprojectp/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'SignIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final _auth = FirebaseAuth.instance; //initialize firebase
  bool _passwordVisible = false; //for password visibility toggle
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
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
                const SizedBox(height: 40),
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
                    const SizedBox(width: 10.0),
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
                const SizedBox(height: 31),
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
                        // const SizedBox(height: 7),
                        buildInputField(
                          hintText: 'Email',
                          prefixIcon: Icons.mail_outline_rounded,
                          controller: emailController,
                        ),
                        //const SizedBox(height: 7),
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
                        const SizedBox(height: 50),
                        SizedBox(
                          height: 40,
                          width: 140,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffc780ff),
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
                              if (_formKey.currentState!.validate()) {
                                _auth
                                    .createUserWithEmailAndPassword(
                                        email: emailController.text.toString(),
                                        password:
                                            passwordController.text.toString())
                                    .then((value) {})
                                    .onError((error, stackTrace) {
                                  Utils().toastMessage(error.toString());
                                });

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
                const SizedBox(height: 15),
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
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSocialIcon(imagePath: "lib/assets/fb.png"),
                    const SizedBox(width: 10),
                    buildSocialIcon(imagePath: "lib/assets/google.png"),
                  ],
                ),
                const SizedBox(height: 75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          ),
                        );
                      },
                      child: Text(
                        'Log in',
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
    bool isNameField = false,
  }) {
    return Container(
      height: 70.23,
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
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(
                prefixIcon,
                size: 20,
                color: Colors.black45,
              ),
            ),
            Expanded(
              child: TextFormField(
                keyboardType: isPassword
                    ? TextInputType.visiblePassword
                    : TextInputType.emailAddress,
                controller: controller,
                obscureText: isPassword && !_passwordVisible,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 9),
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffc780ff),
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
                            size: 20,
                          ),
                        )
                      : null,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return isPassword
                        ? 'Please enter a password'
                        : isNameField
                            ? 'Please enter your name'
                            : 'Please enter your mail address';
                  }
                  if (isPassword && value.length < 6) {
                    return 'Enter at least 6 characters long';
                  }
                  if (!isPassword &&
                      !isNameField &&
                      !value.contains('@') &&
                      !value.endsWith('.com')) {
                    return 'Kindly enter valid mail';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
