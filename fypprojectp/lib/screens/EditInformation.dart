import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fypprojectp/screens/Sqflite/DatabaseHelper.dart';
import 'package:fypprojectp/screens/home.dart';
import 'package:fypprojectp/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

String? mail_address;

class EditInformation extends StatefulWidget {
  const EditInformation({super.key});

  @override
  State<EditInformation> createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  final _databaseHelper = DatabaseHelper();
  // final _formKey = GlobalKey<FormState>();

  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _cnicController;
  late TextEditingController _bloodgroupController;
  late TextEditingController _addressController;
  late TextEditingController _emerContactController;
  late TextEditingController _emerContact1Controller;
  late TextEditingController _emerContact2Controller;

  UserRecord _userRecord = UserRecord(
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

  @override
  void initState() {
    super.initState();
    //_databaseHelper.initializeDatabase();
    _fullNameController = TextEditingController();
    _cnicController = TextEditingController();
    _bloodgroupController = TextEditingController();
    _addressController = TextEditingController();
    _emerContactController = TextEditingController();
    _emailController = TextEditingController();
    _emerContact1Controller = TextEditingController();
    _emerContact2Controller = TextEditingController();

    Future.delayed(Duration(seconds: 2), () {
      _showImportantNoteAlert();
    });
  }

  File? _image;

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

  void saveInformation() async {
    _addUser();
    //delay for few second
    await Future.delayed(Duration(seconds: 3));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
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
                  backgroundColor: Colors.blueGrey.shade100,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? Icon(
                          Icons.person_add_alt_sharp,
                          size: 23.0,
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

  void _addUser() async {
    // String fullName = _fullNameController.text;

    final record = UserRecord(
      fullName: _fullNameController.text,
      cnic: _cnicController.text,
      bloodGroup: _bloodgroupController.text,
      address: _addressController.text,
      emerContact: _emerContactController.text,
      emeContact: _emerContact1Controller.text,
      emContact: _emerContact2Controller.text,
      email: _emailController.text,
      imageBytes: _userRecord.imageBytes,
    );
    try {
      await _databaseHelper.initializeDatabase();
      await _databaseHelper.insertUserData(record);

      // Print statements to check if data is saved correctly
      print('Data saved successfully:');
      print('Full Name: ${record.fullName}');
      print('CNIC: ${record.cnic}');
      print('Blood Group: ${record.bloodGroup}');
      print('Address: ${record.address}');
      print('Email: ${record.email}');
      print('Emergency Contact: ${record.emerContact}');
      print('Image Bytes: ${record.imageBytes}');
      mail_address = _emailController.text;

      Utils().toastMessage('Saved Successfully!');
    } catch (e) {
      Utils().toastMessage('Error! data not saved');
    }
  }
}

class UserRecord {
  String fullName,
      cnic,
      bloodGroup,
      emerContact,
      email,
      emeContact,
      emContact,
      address;
  Uint8List imageBytes;

  UserRecord({
    required this.fullName,
    required this.cnic,
    required this.bloodGroup,
    required this.address,
    required this.emerContact,
    required this.emContact,
    required this.emeContact,
    required this.email,
    required this.imageBytes,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'fullName': fullName,
      'email': email,
      'cnic': cnic,
      'bloodGroup': bloodGroup,
      'address': address,
      'emerContact': emerContact,
      'emeContact': emeContact,
      'emContact': emContact,
      'imageBytes': imageBytes,
    };
    return map;
  }
}
