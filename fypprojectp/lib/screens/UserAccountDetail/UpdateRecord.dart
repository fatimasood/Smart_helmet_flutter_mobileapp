import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fypprojectp/screens/Authentication/SignUp.dart';
import 'package:fypprojectp/screens/Sqflite/DatabaseHelper.dart';
import 'package:fypprojectp/screens/UserAccountDetail/EditInformation.dart';
import 'package:fypprojectp/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UpdateRecord extends StatefulWidget {
  const UpdateRecord({Key? key}) : super(key: key);

  @override
  _UpdateRecordState createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _cnicController;
  late TextEditingController _bloodgroupController;
  late TextEditingController _addressController;
  late TextEditingController _emerContactController;
  late TextEditingController _emerContact1Controller;
  late TextEditingController _emerContact2Controller;

  File? _image;
  late UserRecord _userRecord;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _cnicController = TextEditingController();
    _bloodgroupController = TextEditingController();
    _addressController = TextEditingController();
    _emerContactController = TextEditingController();
    _emailController = TextEditingController();
    _emerContact1Controller = TextEditingController();
    _emerContact2Controller = TextEditingController();
    _userRecord = UserRecord(
      fullName: '',
      cnic: '',
      bloodGroup: '',
      address: '',
      emerContact: '',
      emContact: '',
      emeContact: '',
      email: '',
      imageBytes: Uint8List(0),
    );

    Future.delayed(const Duration(seconds: 2), () {
      _showImportantNoteAlert();
      _loadData();
    });
  }

  Future<void> _loadData() async {
    // Fetch the user record by email
    String? email = userMail;

    UserRecord? userRecord = await _databaseHelper.getRecordByName(email!);

    // Update the state with the fetched user record
    setState(() {
      _userRecord = userRecord ?? _userRecord;

      _fullNameController.text = _userRecord.fullName;
      _emailController.text = _userRecord.email;
      _cnicController.text = _userRecord.cnic;
      _bloodgroupController.text = _userRecord.bloodGroup;
      _addressController.text = _userRecord.address;
      _emerContactController.text = _userRecord.emerContact;
      _emerContact1Controller.text = _userRecord.emeContact;
      _emerContact2Controller.text = _userRecord.emContact;
    });
  }

  Future<void> updateRecordInDatabase() async {
    if (_validateForm()) {
      String fullName = _fullNameController.text;
      String cnic = _cnicController.text;
      String bloodGroup = _bloodgroupController.text;
      String emerContact = _emerContactController.text;
      String email = _emailController.text;
      String emeContact = _emerContact1Controller.text;
      String emContact = _emerContact2Controller.text;
      String address = _addressController.text;

      UserRecord updatedRecord = UserRecord(
        fullName: fullName,
        cnic: cnic,
        bloodGroup: bloodGroup,
        address: address,
        emerContact: emerContact,
        emContact: emContact,
        emeContact: emeContact,
        email: email,
        imageBytes: _userRecord.imageBytes,
      );

      try {
        await _databaseHelper.updateUserRecord(updatedRecord);
        Utils().toastMessage('Record updated successfully!');
        Navigator.pop(context);
      } catch (error) {
        print('Error updating record: $error');
        Utils().toastMessage('Error updating record. Please try again.');
      }
    }
  }

  bool _validateForm() {
    if (_cnicController.text.length != 13) {
      Utils().toastMessage('CNIC must be 13 digits');
      return false;
    }
    if (_emerContactController.text.length != 11 ||
        _emerContact1Controller.text.length != 11 ||
        _emerContact2Controller.text.length != 11) {
      Utils().toastMessage('Contact number must be 11 digits');
      return false;
    }
    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _cnicController.text.isEmpty ||
        _bloodgroupController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _emerContactController.text.isEmpty ||
        _emerContact1Controller.text.isEmpty ||
        _emerContact2Controller.text.isEmpty ||
        (_image == null || _userRecord.imageBytes.isEmpty)) {
      Utils().toastMessage('Please enter all Info');
      return false;
    }

    return true;
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      List<int> imageBytes = await _image!.readAsBytes();
      setState(() {
        _userRecord.imageBytes = Uint8List.fromList(imageBytes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 214, 249),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 15),
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 40.0,
                  //backgroundColor: Colors.blueGrey.shade100,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? Image.asset(
                          'lib/assets/Group9.png',
                          width: 110.0,
                          height: 110.0,
                        )
                      : null,
                ),
              ),
            ),
            Text(
              "Create Profile",
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff6617ff),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Container(
                height: 570,
                width: 340,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 243, 240, 250),
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
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(
                              color: Color(0xff6617ff),
                              width: 1.5,
                            )),
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: _fullNameController,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 170, 141, 227),
                            ),
                          ),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'Full Name',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 170, 141, 227),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Info required, fill all fields';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(
                              color: Color(0xff6617ff),
                              width: 1.5,
                            )),
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: _emailController,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 170, 141, 227),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 170, 141, 227),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Info required, fill all fields';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(
                              color: Color(0xff6617ff),
                              width: 1.5,
                            )),
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: _cnicController,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 170, 141, 227),
                            ),
                          ),
                          decoration: InputDecoration(
                            hintText: 'CNIC',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 170, 141, 227),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Info required, fill all fields';
                            } else if (value.length != 13) {
                              return 'Contact number must be 11 digits';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(
                              color: Color(0xff6617ff),
                              width: 1.5,
                            )),
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: _bloodgroupController,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 170, 141, 227),
                            ),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Blood Group',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 170, 141, 227),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Info required, fill all fields';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              border: Border.all(
                                color: Color(0xff6617ff),
                                width: 1.5,
                              )),
                          padding:
                              EdgeInsets.only(left: 5, right: 5, bottom: 1.5),
                          child: TextFormField(
                            controller: _addressController,
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 170, 141, 227),
                              ),
                            ),
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              hintText: 'Address',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 170, 141, 227),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Info required, fill all fields';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          border: Border.all(
                            color: Color(0xff6617ff),
                            width: 1.5,
                          ),
                        ),
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: _emerContactController,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 170, 141, 227),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Emergency Contact',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 170, 141, 227),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Info required, fill all fields';
                            } else if (value.length != 11) {
                              return 'Contact number must be 11 digits';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          border: Border.all(
                            color: Color(0xff6617ff),
                            width: 1.5,
                          ),
                        ),
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: _emerContact1Controller,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 170, 141, 227),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Emergency Contact',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 170, 141, 227),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Info required, fill all fields';
                            } else if (value.length != 11) {
                              return 'Contact number must be 11 digits';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          border: Border.all(
                            color: Color(0xff6617ff),
                            width: 1.5,
                          ),
                        ),
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: _emerContact2Controller,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 170, 141, 227),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Emergency Contact',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 170, 141, 227),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Info required, fill all fields';
                            } else if (value.length != 11) {
                              return 'Contact number must be 11 digits';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      GestureDetector(
                        onTap: updateRecordInDatabase,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Save",
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Color(0xff6617ff),
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
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

  void _showImportantNoteAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Important Note',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff6617ff),
                fontWeight: FontWeight.w800,
                fontSize: 18),
          ),
          content: Text(
            '1) Write email address that you was used for account registration.\n2) Write your CNIC, must be 13 digits.\n3) Address format (city,Mohalla,street number,home number, postal code) \n4) Must add 3 emergency contact numbers ',
            style: TextStyle(
                color: Color(0xff6617ff),
                fontWeight: FontWeight.w400,
                fontSize: 13),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(
                    color: Color(0xff6617ff),
                    fontWeight: FontWeight.w800,
                    fontSize: 15),
              ),
            ),
          ],
        );
      },
    );
  }
}
