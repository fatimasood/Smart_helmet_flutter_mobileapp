import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.grey.shade400,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: Icon(
                    Icons.add_a_photo,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              "Create Profile",
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff9d6bff),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 30),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: Color(0xff6617ff), width: 2.0),
                  color: Colors.white),
              height: 50,
              width: 310,
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(
                          color: Color(0xff9d6bff),
                          fontWeight: FontWeight.w300),
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 5),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: Color(0xff6617ff), width: 2.0),
                  color: Colors.white),
              height: 50,
              width: 310,
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'CNIC',
                      hintStyle: TextStyle(
                          color: Color(0xff9d6bff),
                          fontWeight: FontWeight.w300),
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 5),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: Color(0xff6617ff), width: 2.0),
                  color: Colors.white),
              height: 50,
              width: 310,
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Address',
                      hintStyle: TextStyle(
                          color: Color(0xff9d6bff),
                          fontWeight: FontWeight.w300),
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 5),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: Color(0xff6617ff), width: 2.0),
                  color: Colors.white),
              height: 50,
              width: 310,
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Blood Group',
                      hintStyle: TextStyle(
                          color: Color(0xff9d6bff),
                          fontWeight: FontWeight.w300),
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 5),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: Color(0xff6617ff), width: 2.0),
                  color: Colors.white),
              height: 50,
              width: 310,
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Emergency Contact',
                      hintStyle: TextStyle(
                          color: Color(0xff9d6bff),
                          fontWeight: FontWeight.w300),
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
