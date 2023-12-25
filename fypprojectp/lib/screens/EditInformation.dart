import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'home.dart';

class EditInformation extends StatefulWidget {
  const EditInformation({super.key});

  @override
  State<EditInformation> createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void saveInformation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffede5fd),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80, bottom: 15),
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 45.0,
                  backgroundColor: Colors.blueGrey.shade100,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: Icon(
                    Icons.person_add_alt_sharp,
                    size: 35.0,
                  ),
                ),
              ),
            ),
            Text(
              "Create Profile",
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff6617ff),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Container(
                height: 450,
                width: 340,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0 * 5, 4 * 3),
                      blurRadius: 2 * 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(
                              color: Color(0xff6617ff),
                              width: 1.5,
                            )),
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Full Name',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 170, 141, 227),
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(
                              color: Color(0xff6617ff),
                              width: 1.5,
                            )),
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'CNIC',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 170, 141, 227),
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(
                              color: Color(0xff6617ff),
                              width: 1.5,
                            )),
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Blood Group',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 170, 141, 227),
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(
                              color: Color(0xff6617ff),
                              width: 1.5,
                            )),
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Address',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 170, 141, 227),
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(
                              color: Color(0xff6617ff),
                              width: 1.5,
                            )),
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Emergency Contact',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 170, 141, 227),
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      GestureDetector(
                          onTap: saveInformation,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "Save",
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(
                                      0xff6617ff), // Change color if needed
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
