import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fypprojectp/screens/Sqflite/DatabaseHelper.dart';
import 'package:fypprojectp/screens/home.dart';
import 'package:fypprojectp/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'NavigationScreens/SignUp.dart';

String? loggedInUserEmail = userMail;

class EditInformation extends StatefulWidget {
  const EditInformation({super.key});

  @override
  State<EditInformation> createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  final _databaseHelper = DatabaseHelper();
  //final _formKey = GlobalKey<FormState>();

  late TextEditingController _fullNameController;
  late TextEditingController _cnicController;
  late TextEditingController _bloodgroupController;
  late TextEditingController _addressController;
  late TextEditingController _emerContactController;

  UserRecord _userRecord = UserRecord(
    fullName: '',
    cnic: '',
    bloodGroup: '',
    address: '',
    emerContact: '',
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
                          controller: _fullNameController,
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
                          controller: _cnicController,
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
                          controller: _bloodgroupController,
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
                          controller: _addressController,
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
                          controller: _emerContactController,
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
                                color: Color(0xff6617ff),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
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

  void _addUser() async {
    // String fullName = _fullNameController.text;

    final record = UserRecord(
      fullName: _fullNameController.text,
      cnic: _cnicController.text,
      bloodGroup: _bloodgroupController.text,
      address: _addressController.text,
      emerContact: _emerContactController.text,
      imageBytes: _userRecord.imageBytes,
    );
    try {
      await _databaseHelper.initializeDatabase();
      await _databaseHelper.insertUserData(record);

      Utils().toastMessage('Saved Successfully!');
    } catch (e) {
      Utils().toastMessage('Error! data not saved');
    }
  }
}

class UserRecord {
  String fullName, cnic, bloodGroup, emerContact, address;
  Uint8List imageBytes;

  UserRecord({
    required this.fullName,
    required this.cnic,
    required this.bloodGroup,
    required this.address,
    required this.emerContact,
    required this.imageBytes,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'fullName': fullName,
      'cnic': cnic,
      'bloodGroup': bloodGroup,
      'address': address,
      'emerContact': emerContact,
      'imageBytes': imageBytes,
    };
    return map;
  }
}
