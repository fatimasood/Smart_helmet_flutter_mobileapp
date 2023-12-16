import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class account extends StatefulWidget {
  const account({super.key});

  @override
  State<account> createState() => _AccountState();
}

class _AccountState extends State<account> {
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

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            height: 350.0, // Custom height
            width: 350.0, // Custom width
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.grey.shade400,
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: Icon(
                        Icons.add_a_photo,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Create Profile",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff9d6bff),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                // Rest of your code for text fields can be added here
                // Example:
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(color: Color(0xff6617ff), width: 2.0),
                    color: Colors.transparent,
                  ),
                  height: 50,
                  width: 310,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          color: Color(0xff9d6bff),
                          fontWeight: FontWeight.w300,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                // Add other text fields similarly
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    _showCustomDialog(context);
                  },
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.grey.shade400,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: Icon(
                      Icons.add_a_photo,
                      size: 30.0,
                    ),
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
