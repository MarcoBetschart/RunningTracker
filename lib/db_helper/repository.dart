import 'package:sqflite/sqflite.dart';

import 'database_connection.dart';

/// Repository that executes CRUD methods
class Repository {
  /// Connection to SQLite database
  late DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;

  /// Set the connection or create database
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  /// Insert run
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  /// Read all Record
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  /// Read a single record by ID
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  /// Update run
  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  /// Delete run
  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
}
