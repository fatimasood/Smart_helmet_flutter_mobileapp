import 'dart:async';

import 'package:fypprojectp/screens/EditInformation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

late Database _database;

class DatabaseHelper {
  Future<void> initializeDatabase() async {
    String path = await getDatabasesPath();
    _database = await openDatabase(
      join(path, 'smarthelmet.db'),
      onCreate: (db, version) {
        return db.execute(
            '''
          CREATE TABLE user_records(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fullName TEXT,
            cnic TEXT,
            bloodGroup TEXT,
            address TEXT,
            emerContact TEXT
          )
        ''');
      },
      version: 2,
    );
  }

//insert record
  Future<void> insertUserData(UserRecord record) async {
    await _database.insert('user_records', record.toMap());
  }

//update record
  Future<void> updateUserRecord(UserRecord record) async {
    await _database.update(
      'attendence_records',
      {
        'fullName': record.fullName,
        'cnic': record.cnic,
        'bloodgroup': record.bloodGroup,
        'address': record.address,
        'phoneNumber': record.emerContact,
      },
      where: 'fullName = ? ',
      whereArgs: [
        record.fullName,
      ],
    );
  }

  /*Future<UserRecord?> getAttendanceRecordByNameAndDate(
      String firstName,) async {
    print('Searching for: $firstName $lastName on $date');

    final List<Map<String, dynamic>> records = await _database.query(
      'attendence_records',
      where: 'LOWER(firstName) = ? AND LOWER(lastName) = ? AND date = ?',
      whereArgs: [
        firstName.toLowerCase(),
        lastName.toLowerCase(),
        DateFormat('yyyy-MM-dd').format(date),
      ],
      limit: 1,
    );

    if (records.isNotEmpty) {
      print('Record found:');
      print(records[0]); // Print the found record for more details
      return UserRecord(
        firstName: records[0]['firstName'],
        lastName: records[0]['lastName'],
        regNum: records[0]['registrationNumber'],
        className: records[0]['className'],
        //req: records[0]['req'],
        date: DateTime.parse(records[0]['date']),
        isPresent: records[0]['isPresent'] == 1,
      );
    } else {
      print('No record found for: $firstName $lastName on $date');
      return null;
    }
  }*/

  Future<UserRecord?> getUserRecordByName(String fullName) async {
    final List<Map<String, dynamic>> records = await _database.query(
      'user_records',
      where: 'LOWER(fullName) = ? ',
      whereArgs: [fullName.toLowerCase()],

      orderBy: 'id DESC',
      limit: 1, // Limit set
    );

    if (records.isNotEmpty) {
      return UserRecord(
        fullName: records[0]['fullName'],
        cnic: records[0]['cnic'],
        bloodGroup: records[0]['bloodgroup'],
        emerContact: records[0]['emercontact'],
        address: records[0]['address'],
      );
    } else {
      return null;
    }
  }
}
