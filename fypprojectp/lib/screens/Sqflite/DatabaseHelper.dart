import 'dart:async';

import 'package:fypprojectp/screens/EditInformation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

late Database _database;

class DatabaseHelper {
  Future<void> initializeDatabase() async {
    try {
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
              emerContact TEXT,
              imageBytes BLOB
            )
          ''');
        },
        version: 2,
      );
      print('Database initialized successfully');
    } catch (e) {
      print('Error initializing database: $e');
    }
  }

  Future<void> insertUserData(UserRecord record) async {
    await _database.insert('user_records', {
      'fullName': record.fullName,
      'cnic': record.cnic,
      'bloodGroup': record.bloodGroup,
      'address': record.address,
      'emerContact': record.emerContact,
      'imageBytes': record.imageBytes,
    });
  }

  Future<List<UserRecord>> getAllUserRecordForUser(String userName) async {
    // Remove spaces and convert to lowercase
    final cleanedUserName = userName.replaceAll(' ', '').toLowerCase();

    final List<Map<String, dynamic>> records = await _database.query(
      'user_records',
      where: 'fullName = ?',
      whereArgs: [cleanedUserName],
    );

    return records.map((record) {
      return UserRecord(
        fullName: record['fullName'],
        cnic: record['cnic'],
        bloodGroup: record['bloodGroup'],
        emerContact: record['emerContact'],
        address: record['address'],
        imageBytes: record['imageBytes'],
      );
    }).toList();
  }
}
