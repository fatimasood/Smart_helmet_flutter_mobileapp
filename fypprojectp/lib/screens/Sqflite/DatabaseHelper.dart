import 'dart:async';

import 'package:fypprojectp/screens/UserAccountDetail/EditInformation.dart';
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
          email TEXT,
          cnic TEXT,
          bloodGroup TEXT,
          address TEXT,
          emerContact TEXT,
          emeContact TEXT,
          emContact TEXT,
          imageBytes BLOB
        )
      ''',
        );
      },
      version: 2,
    );
  }

  Future<void> insertUserData(UserRecord record) async {
    await _database.insert(
      'user_records',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<UserRecord?> getRecordByName(String mailAddress) async {
    final List<Map<String, dynamic>> records = await _database.query(
      'user_records',
      where: 'email = ?',
      whereArgs: [mailAddress],

      limit: 1, // Limit set
    );

    if (records.isNotEmpty) {
      return UserRecord(
        fullName: records[0]['fullName'],
        email: records[0]['email'],
        cnic: records[0]['cnic'],
        bloodGroup: records[0]['bloodGroup'],
        emerContact: records[0]['emerContact'],
        emContact: records[0]['emContact'],
        emeContact: records[0]['emeContact'],
        address: records[0]['address'],
        imageBytes: records[0]['imageBytes'],
      );
    } else {
      return null;
    }
  }

  Future<void> updateUserRecord(UserRecord record) async {
    await _database.update(
      'user_records',
      {
        'fullName': record.fullName,
        'cnic': record.cnic,
        'email': record.email,
        'bloodGroup': record.bloodGroup,
        'emerContact': record.emerContact,
        'emeContact': record.emeContact,
        'emContact': record.emContact,
        'address': record.address,
        'imageBytes': record.imageBytes,
      },
      where: 'email = ?',
      whereArgs: [
        record.email,
      ],
    );
  }

  Future<List<UserRecord>> getAllUserRecordForUser(String mailAddress) async {
    final List<Map<String, dynamic>> records = await _database.query(
      'user_records',
      where: 'email = ?',
      whereArgs: [mailAddress],
    );

    return records.map((record) {
      return UserRecord(
        fullName: record['fullName'],
        email: record['email'],
        cnic: record['cnic'],
        bloodGroup: record['bloodGroup'],
        emerContact: record['emerContact'],
        emContact: record['emContact'],
        emeContact: record['emeContact'],
        address: record['address'],
        imageBytes: record['imageBytes'],
      );
    }).toList();
  }

  Future<Map<String, Object?>?> loadImage(String mailAddress) async {
    final results = await _database
        .query('user_records', where: 'email = ?', whereArgs: [mailAddress]);
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  Future<void> deleteUser(String mailAddress) async {
    print('Deleting records for mail: $mailAddress');
    await _database
        .delete('user_records', where: 'email = ?', whereArgs: [mailAddress]);
  }
}
